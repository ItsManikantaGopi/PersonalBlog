import fs from 'node:fs'
import path from 'node:path'
import matter from 'gray-matter'
import { unified } from 'unified'
import remarkParse from 'remark-parse'
import remarkGfm from 'remark-gfm'
import remarkRehype from 'remark-rehype'
import rehypeSlug from 'rehype-slug'
import rehypeAutolinkHeadings from 'rehype-autolink-headings'
import rehypePrettyCode, { type Options as PrettyCodeOptions } from 'rehype-pretty-code'
import rehypeStringify from 'rehype-stringify'

const CONTENT_ROOT = path.join(process.cwd(), 'content')

export type Collection = 'projects' | 'posts'

type FrontMatter = {
  title: string
  summary: string
  date: string
  /** Projects only: the period the work spans, e.g. "2025 – 2026". */
  period?: string
  /** Projects only: my relationship to the work. */
  role?: string
  tags?: string[]
  stack?: string[]
  /** External links — repository, package, live site. */
  links?: { label: string; href: string }[]
  /** Pin to the top of listings and surface on the home page. */
  featured?: boolean
  /** Manual ordering within a listing; lower sorts first. Defaults to 100. */
  weight?: number
  /** Hide from listings without deleting the file. */
  draft?: boolean
}

export type Doc = FrontMatter & {
  slug: string
  collection: Collection
  html: string
  readingMinutes: number
  headings: { depth: number; text: string; id: string }[]
}

export type DocMeta = Omit<Doc, 'html' | 'headings'>

/**
 * Shiki themes for the two colour schemes. rehype-pretty-code emits both as CSS
 * variables on every token and the stylesheet picks one, so highlighting follows
 * the theme with no flash and no client-side re-render.
 *
 * Declared as a typed constant rather than inline: passing an object literal
 * straight into `.use()` makes TypeScript resolve the wrong plugin overload.
 */
const prettyCodeOptions: PrettyCodeOptions = {
  theme: { light: 'github-light', dark: 'github-dark-dimmed' },
  keepBackground: false,
}

function processor() {
  return unified()
    .use(remarkParse)
    .use(remarkGfm)
    .use(remarkRehype)
    .use(rehypeSlug)
    .use(rehypeAutolinkHeadings, {
      behavior: 'wrap',
      properties: { className: ['heading-anchor'] },
    })
    .use(rehypePrettyCode, prettyCodeOptions)
    .use(rehypeStringify, { allowDangerousHtml: true })
}

function collectionDir(collection: Collection) {
  return path.join(CONTENT_ROOT, collection)
}

/**
 * Wide tables must scroll inside their own box rather than widening the page.
 * Markdown tables never nest, so a straight tag substitution is safe here.
 */
function wrapTables(html: string): string {
  return html
    .replace(/<table>/g, '<div class="table-scroll"><table>')
    .replace(/<\/table>/g, '</table></div>')
}

/**
 * Hand mermaid fences to the client renderer. rehype-pretty-code has already
 * turned the fence into a highlighted <pre>, so instead of unpicking that we
 * read the diagram source straight from the markdown and swap the block out.
 */
function extractMermaid(html: string, markdown: string): string {
  const diagrams = [...markdown.matchAll(/^```mermaid\n([\s\S]*?)^```/gm)].map((m) => m[1])
  if (diagrams.length === 0) return html

  let index = 0
  return html.replace(
    /<figure[^>]*data-rehype-pretty-code-figure[^>]*>\s*<pre[^>]*data-language="mermaid"[\s\S]*?<\/figure>/g,
    () => {
      const source = diagrams[index++]
      if (source === undefined) return ''
      // The source is escaped into a data attribute; the client component reads
      // it back and never injects it as HTML.
      const encoded = Buffer.from(source, 'utf8').toString('base64')
      return `<div class="mermaid-block" data-mermaid="${encoded}" data-rendered="false"></div>`
    },
  )
}

export function listSlugs(collection: Collection): string[] {
  const dir = collectionDir(collection)
  if (!fs.existsSync(dir)) return []
  return fs
    .readdirSync(dir)
    .filter((f) => f.endsWith('.md'))
    .map((f) => f.replace(/\.md$/, ''))
}

/**
 * Words per minute is a fiction, but a consistent one. 200 is the usual figure
 * and it's only ever used as a rough signal of length.
 */
function estimateReadingMinutes(raw: string): number {
  const words = raw.trim().split(/\s+/).length
  return Math.max(1, Math.round(words / 200))
}

function extractHeadings(raw: string) {
  const headings: { depth: number; text: string; id: string }[] = []
  const lines = raw.split('\n')
  let inFence = false

  for (const line of lines) {
    if (/^\s*(```|~~~)/.test(line)) {
      inFence = !inFence
      continue
    }
    if (inFence) continue

    const match = /^(#{2,3})\s+(.*)$/.exec(line)
    if (!match) continue

    const depth = match[1].length
    // Strip inline markdown so the table of contents reads as plain text.
    const text = match[2]
      .replace(/`([^`]+)`/g, '$1')
      .replace(/\*\*([^*]+)\*\*/g, '$1')
      .replace(/\[([^\]]+)\]\([^)]*\)/g, '$1')
      .trim()

    // Must match rehype-slug's github-slugger output.
    const id = text
      .toLowerCase()
      .replace(/[^\w\s-]/g, '')
      .trim()
      .replace(/\s+/g, '-')

    headings.push({ depth, text, id })
  }

  return headings
}

export async function getDoc(collection: Collection, slug: string): Promise<Doc | null> {
  const file = path.join(collectionDir(collection), `${slug}.md`)
  if (!fs.existsSync(file)) return null

  const source = fs.readFileSync(file, 'utf8')
  const { data, content } = matter(source)
  const fm = data as FrontMatter

  const compiled = await processor().process(content)

  return {
    ...fm,
    tags: fm.tags ?? [],
    stack: fm.stack ?? [],
    links: fm.links ?? [],
    slug,
    collection,
    html: extractMermaid(wrapTables(String(compiled)), content),
    readingMinutes: estimateReadingMinutes(content),
    headings: extractHeadings(content),
  }
}

/**
 * Metadata for every document in a collection, newest first, drafts excluded.
 * Featured documents float to the top.
 */
export async function listDocs(collection: Collection): Promise<DocMeta[]> {
  const slugs = listSlugs(collection)

  const docs = slugs.map((slug) => {
    const file = path.join(collectionDir(collection), `${slug}.md`)
    const { data, content } = matter(fs.readFileSync(file, 'utf8'))
    const fm = data as FrontMatter
    return {
      ...fm,
      tags: fm.tags ?? [],
      stack: fm.stack ?? [],
      links: fm.links ?? [],
      slug,
      collection,
      readingMinutes: estimateReadingMinutes(content),
    } satisfies DocMeta
  })

  return docs
    .filter((d) => !d.draft)
    .sort((a, b) => {
      // Featured first, then explicit weight, then newest. Weight exists because
      // "most recent" is the wrong lead for a portfolio — the work I most want
      // read is not necessarily the work I touched last.
      if (a.featured !== b.featured) return a.featured ? -1 : 1
      const weightDelta = (a.weight ?? 100) - (b.weight ?? 100)
      if (weightDelta !== 0) return weightDelta
      return b.date.localeCompare(a.date)
    })
}

export async function listTags(collection: Collection): Promise<{ tag: string; count: number }[]> {
  const docs = await listDocs(collection)
  const counts = new Map<string, number>()
  for (const doc of docs) {
    for (const tag of doc.tags ?? []) {
      counts.set(tag, (counts.get(tag) ?? 0) + 1)
    }
  }
  return [...counts.entries()]
    .map(([tag, count]) => ({ tag, count }))
    .sort((a, b) => b.count - a.count || a.tag.localeCompare(b.tag))
}

export function formatDate(iso: string): string {
  const date = new Date(`${iso}T00:00:00Z`)
  return date.toLocaleDateString('en-GB', {
    day: 'numeric',
    month: 'short',
    year: 'numeric',
    timeZone: 'UTC',
  })
}
