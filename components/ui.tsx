import Link from 'next/link'
import type { ReactNode } from 'react'
import type { DocMeta } from '@/lib/content'
import { formatDate } from '@/lib/content'

export function Section({
  title,
  action,
  children,
}: {
  title: string
  action?: ReactNode
  children: ReactNode
}) {
  return (
    <section className="mt-16">
      <div className="mb-5 flex items-baseline justify-between gap-4 border-b border-border-base pb-2">
        <h2 className="font-mono text-xs font-medium tracking-widest text-text-faint uppercase">
          {title}
        </h2>
        {action}
      </div>
      {children}
    </section>
  )
}

export function Tag({ children }: { children: ReactNode }) {
  return (
    <span className="rounded border border-border-base bg-bg-subtle px-1.5 py-0.5 font-mono text-[11px] leading-relaxed text-text-muted">
      {children}
    </span>
  )
}

export function TagRow({ items, limit }: { items: string[]; limit?: number }) {
  if (items.length === 0) return null
  const shown = limit ? items.slice(0, limit) : items
  const rest = limit ? items.length - shown.length : 0

  return (
    <div className="flex flex-wrap items-center gap-1.5">
      {shown.map((item) => (
        <Tag key={item}>{item}</Tag>
      ))}
      {rest > 0 && <span className="font-mono text-[11px] text-text-faint">+{rest}</span>}
    </div>
  )
}

/**
 * One row in a listing. Deliberately dense — a visitor scanning the page should
 * be able to read every title without scrolling past decoration.
 */
export function DocRow({ doc }: { doc: DocMeta }) {
  const base = doc.collection === 'projects' ? '/work' : '/writing'
  const meta = doc.collection === 'projects' ? doc.period : formatDate(doc.date)

  return (
    <li className="group border-b border-border-base last:border-0">
      <Link href={`${base}/${doc.slug}/`} className="block py-4">
        <div className="flex items-baseline justify-between gap-4">
          <h3 className="font-medium text-text transition-colors group-hover:text-accent">
            {doc.title}
          </h3>
          {meta && (
            <span className="shrink-0 font-mono text-xs whitespace-nowrap text-text-faint">
              {meta}
            </span>
          )}
        </div>
        <p className="mt-1.5 text-sm leading-relaxed text-text-muted">{doc.summary}</p>
        {(doc.stack?.length ?? 0) > 0 && (
          <div className="mt-2.5">
            <TagRow items={doc.stack ?? []} limit={6} />
          </div>
        )}
      </Link>
    </li>
  )
}

export function DocList({ docs }: { docs: DocMeta[] }) {
  if (docs.length === 0) {
    return <p className="text-sm text-text-muted">Nothing here yet.</p>
  }
  return (
    <ul className="-mt-4">
      {docs.map((doc) => (
        <DocRow key={doc.slug} doc={doc} />
      ))}
    </ul>
  )
}

export function ExternalLinks({ links }: { links: { label: string; href: string }[] }) {
  if (links.length === 0) return null
  return (
    <div className="flex flex-wrap gap-x-4 gap-y-2">
      {links.map((link) => (
        <a
          key={link.href}
          href={link.href}
          target="_blank"
          rel="noreferrer noopener"
          className="inline-flex items-center gap-1 font-mono text-xs text-accent hover:underline"
        >
          {link.label}
          <svg
            width="11"
            height="11"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2.2"
            strokeLinecap="round"
            strokeLinejoin="round"
            aria-hidden
          >
            <path d="M7 17 17 7M9 7h8v8" />
          </svg>
        </a>
      ))}
    </div>
  )
}
