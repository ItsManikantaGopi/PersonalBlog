import type { Metadata } from 'next'
import Link from 'next/link'
import { education, intro, roles, site, skillGroups, social } from '@/lib/profile'
import { Section, TagRow } from '@/components/ui'

export const metadata: Metadata = {
  title: 'About',
  description: `${site.name} — ${site.role}. Experience, stack and how to get in touch.`,
}

const depthLabel = {
  core: 'reach for first',
  working: 'comfortable',
  familiar: 'shipped with',
} as const

export default function AboutPage() {
  return (
    <>
      <header>
        <h1 className="text-2xl font-semibold tracking-tight">About</h1>
        <div className="mt-4 space-y-3.5 text-[0.975rem] leading-relaxed text-text-muted">
          {intro.map((paragraph) => (
            <p key={paragraph.slice(0, 24)}>{paragraph}</p>
          ))}
          <p>
            Before all of that: a B.Tech in computer science and a machine-learning internship that
            is the reason I still trust an evaluation set over an intuition.
          </p>
        </div>
      </header>

      <Section title="Experience">
        <ol className="space-y-8">
          {roles.map((role) => (
            <li key={`${role.company}-${role.title}-${role.start}`}>
              <div className="flex flex-wrap items-baseline justify-between gap-x-4 gap-y-1">
                <h3 className="font-medium text-text">{role.title}</h3>
                <span className="font-mono text-xs whitespace-nowrap text-text-faint">
                  {role.start} — {role.end}
                </span>
              </div>
              <p className="mt-0.5 text-sm text-text-muted">{role.company}</p>
              <p className="mt-2.5 text-sm leading-relaxed text-text-muted">{role.summary}</p>

              <ul className="mt-3 space-y-2">
                {role.highlights.map((highlight) => (
                  <li
                    key={highlight.slice(0, 32)}
                    className="relative pl-4 text-sm leading-relaxed text-text-muted before:absolute before:top-[0.6em] before:left-0 before:size-1 before:rounded-full before:bg-border-strong"
                  >
                    {highlight}
                  </li>
                ))}
              </ul>

              <div className="mt-3.5">
                <TagRow items={role.stack} />
              </div>
            </li>
          ))}
        </ol>
      </Section>

      <Section title="Stack">
        <p className="mb-6 max-w-prose text-sm leading-relaxed text-text-muted">
          Grouped by how well I actually know each thing, because a flat list of logos tells you
          nothing. <em className="not-italic text-text">Reach for first</em> means I&apos;ve run it
          in production and debugged it at 2am;{' '}
          <em className="not-italic text-text">shipped with</em> means I got the job done and would
          need a day to get sharp again.
        </p>

        <div className="space-y-7">
          {skillGroups.map((group) => (
            <div key={group.name}>
              <h3 className="mb-3 font-mono text-xs tracking-wider text-text-faint">
                {group.name}
              </h3>
              <ul className="grid gap-x-6 gap-y-2.5 sm:grid-cols-2">
                {group.items.map((item) => (
                  <li key={item.name} className="text-sm">
                    <div className="flex items-baseline gap-2">
                      <span
                        className={
                          item.depth === 'core'
                            ? 'font-medium text-text'
                            : 'text-text-muted'
                        }
                      >
                        {item.name}
                      </span>
                      <span
                        className="font-mono text-[10px] text-text-faint"
                        title={depthLabel[item.depth]}
                      >
                        {item.depth}
                      </span>
                    </div>
                    {item.note && (
                      <p className="mt-0.5 text-xs leading-snug text-text-faint">{item.note}</p>
                    )}
                  </li>
                ))}
              </ul>
            </div>
          ))}
        </div>
      </Section>

      <Section title="Education">
        <ul className="space-y-4">
          {education.map((entry) => (
            <li key={`${entry.qualification}-${entry.year}`}>
              <div className="flex flex-wrap items-baseline justify-between gap-x-4">
                <h3 className="text-sm font-medium text-text">{entry.qualification}</h3>
                <span className="font-mono text-xs text-text-faint">{entry.year}</span>
              </div>
              <p className="mt-0.5 text-sm text-text-muted">{entry.institution}</p>
              <p className="mt-0.5 font-mono text-xs text-text-faint">{entry.detail}</p>
            </li>
          ))}
        </ul>
      </Section>

      <Section title="Contact">
        <p className="text-sm leading-relaxed text-text-muted">
          Happy to talk about backend architecture, Kubernetes, queues that lose things, or anything
          on the{' '}
          <Link href="/work/" className="text-accent hover:underline">
            work
          </Link>{' '}
          page.
        </p>
        <ul className="mt-4 space-y-2 font-mono text-sm">
          <li>
            <a href={`mailto:${social.email}`} className="text-accent hover:underline">
              {social.email}
            </a>
          </li>
          <li>
            <a
              href={social.github}
              target="_blank"
              rel="noreferrer noopener"
              className="text-accent hover:underline"
            >
              github.com/{social.githubUser}
            </a>
          </li>
          <li>
            <a
              href={social.linkedin}
              target="_blank"
              rel="noreferrer noopener"
              className="text-accent hover:underline"
            >
              LinkedIn
            </a>
          </li>
        </ul>
      </Section>
    </>
  )
}
