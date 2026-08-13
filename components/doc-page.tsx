import Link from 'next/link'
import type { Doc } from '@/lib/content'
import { formatDate } from '@/lib/content'
import { ExternalLinks, TagRow } from './ui'
import { MermaidRenderer } from './mermaid'

/**
 * Renders one case study or post. Both collections share this shell — the only
 * differences are the back link and which metadata is meaningful.
 */
export function DocPage({ doc }: { doc: Doc }) {
  const isProject = doc.collection === 'projects'
  const backHref = isProject ? '/work/' : '/writing/'
  const backLabel = isProject ? 'Work' : 'Writing'
  const showToc = doc.headings.filter((h) => h.depth === 2).length >= 3

  return (
    <article>
      <Link
        href={backHref}
        className="font-mono text-xs text-text-muted transition-colors hover:text-accent"
      >
        ← {backLabel}
      </Link>

      <header className="mt-5">
        <h1 className="text-2xl font-semibold tracking-tight text-balance sm:text-[1.75rem]">
          {doc.title}
        </h1>

        <p className="mt-3 text-[0.975rem] leading-relaxed text-text-muted">{doc.summary}</p>

        <div className="mt-4 flex flex-wrap items-center gap-x-3 gap-y-1 font-mono text-xs text-text-faint">
          {isProject && doc.period && <span>{doc.period}</span>}
          {isProject && doc.role && (
            <>
              <span aria-hidden>·</span>
              <span>{doc.role}</span>
            </>
          )}
          {!isProject && <span>{formatDate(doc.date)}</span>}
          <span aria-hidden>·</span>
          <span>{doc.readingMinutes} min read</span>
        </div>

        {(doc.stack?.length ?? 0) > 0 && (
          <div className="mt-4">
            <TagRow items={doc.stack ?? []} />
          </div>
        )}

        {(doc.links?.length ?? 0) > 0 && (
          <div className="mt-4">
            <ExternalLinks links={doc.links ?? []} />
          </div>
        )}
      </header>

      {showToc && (
        <nav
          aria-label="On this page"
          className="mt-8 rounded-lg border border-border-base bg-bg-subtle p-4"
        >
          <p className="mb-2 font-mono text-[11px] tracking-widest text-text-faint uppercase">
            On this page
          </p>
          <ol className="space-y-1.5 text-sm">
            {doc.headings
              .filter((h) => h.depth === 2)
              .map((heading) => (
                <li key={heading.id}>
                  <a
                    href={`#${heading.id}`}
                    className="text-text-muted transition-colors hover:text-accent"
                  >
                    {heading.text}
                  </a>
                </li>
              ))}
          </ol>
        </nav>
      )}

      <hr className="mt-8 border-border-base" />

      {/*
        The HTML here is produced at build time by our own markdown pipeline from
        files in this repository. There is no user-supplied input in this path.
      */}
      <div className="prose mt-8" dangerouslySetInnerHTML={{ __html: doc.html }} />

      <MermaidRenderer />

      <hr className="mt-14 border-border-base" />

      <Link
        href={backHref}
        className="mt-6 inline-block font-mono text-xs text-accent hover:underline"
      >
        ← All {backLabel.toLowerCase()}
      </Link>
    </article>
  )
}
