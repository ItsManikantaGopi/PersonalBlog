import Link from 'next/link'
import { listDocs } from '@/lib/content'
import { intro, roles, site, social, stats } from '@/lib/profile'
import { DocList, Section, TagRow } from '@/components/ui'

export default async function HomePage() {
  const [projects, posts] = await Promise.all([listDocs('projects'), listDocs('posts')])

  const featured = projects.filter((p) => p.featured).slice(0, 5)
  const recentPosts = posts.slice(0, 4)
  const current = roles[0]

  return (
    <>
      <section>
        <h1 className="text-2xl font-semibold tracking-tight sm:text-3xl">{site.name}</h1>
        <p className="mt-1.5 font-mono text-sm text-text-muted">
          {site.role} · {site.location}
        </p>

        <div className="mt-6 space-y-3.5 text-[0.975rem] leading-relaxed text-text-muted">
          {intro.map((paragraph) => (
            <p key={paragraph.slice(0, 24)}>{paragraph}</p>
          ))}
        </div>

        <div className="mt-6 flex flex-wrap gap-x-5 gap-y-2 font-mono text-xs">
          <a
            href={social.github}
            target="_blank"
            rel="noreferrer noopener"
            className="text-accent hover:underline"
          >
            GitHub
          </a>
          <a
            href={social.linkedin}
            target="_blank"
            rel="noreferrer noopener"
            className="text-accent hover:underline"
          >
            LinkedIn
          </a>
          <a href={`mailto:${social.email}`} className="text-accent hover:underline">
            {social.email}
          </a>
        </div>
      </section>

      {/* Headline figures. Each has a detail line so none of them float free. */}
      <section className="mt-10 grid grid-cols-2 gap-px overflow-hidden rounded-lg border border-border-base bg-border-base sm:grid-cols-4">
        {stats.map((stat) => (
          <div key={stat.label} className="bg-bg-raised p-3.5">
            <div className="font-mono text-lg font-medium tracking-tight text-text">
              {stat.value}
            </div>
            <div className="mt-0.5 text-xs leading-snug text-text-muted">{stat.label}</div>
            <div className="mt-1.5 text-[11px] leading-snug text-text-faint">{stat.detail}</div>
          </div>
        ))}
      </section>

      <Section
        title="Selected work"
        action={
          <Link href="/work/" className="font-mono text-xs text-accent hover:underline">
            All {projects.length} →
          </Link>
        }
      >
        <DocList docs={featured} />
      </Section>

      <Section title="Currently">
        <div className="rounded-lg border border-border-base bg-bg-raised p-4">
          <div className="flex flex-wrap items-baseline justify-between gap-2">
            <h3 className="font-medium">{current.title}</h3>
            <span className="font-mono text-xs text-text-faint">
              {current.start} — {current.end}
            </span>
          </div>
          <p className="mt-0.5 text-sm text-text-muted">{current.company}</p>
          <p className="mt-3 text-sm leading-relaxed text-text-muted">{current.summary}</p>
          <div className="mt-3.5">
            <TagRow items={current.stack} />
          </div>
          <Link
            href="/about/"
            className="mt-4 inline-block font-mono text-xs text-accent hover:underline"
          >
            Full history →
          </Link>
        </div>
      </Section>

      <Section
        title="Writing"
        action={
          <Link href="/writing/" className="font-mono text-xs text-accent hover:underline">
            All {posts.length} →
          </Link>
        }
      >
        <DocList docs={recentPosts} />
      </Section>
    </>
  )
}
