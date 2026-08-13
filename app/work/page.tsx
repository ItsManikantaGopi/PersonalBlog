import type { Metadata } from 'next'
import { listDocs } from '@/lib/content'
import { DocList } from '@/components/ui'

export const metadata: Metadata = {
  title: 'Work',
  description:
    'Case studies from four years on one platform — the Rails monolith, the services around it, the Kubernetes fleet underneath, and a few things built on the side.',
}

export default async function WorkPage() {
  const projects = await listDocs('projects')

  return (
    <>
      <header>
        <h1 className="text-2xl font-semibold tracking-tight">Work</h1>
        <p className="mt-3 max-w-prose text-[0.975rem] leading-relaxed text-text-muted">
          Systems I&apos;ve built or run, written up with the decisions and the trade-offs intact.
          Where a number appears, it came from a measurement rather than an estimate. Company work
          is described at the architecture level — no internal identifiers, hostnames or
          configuration.
        </p>
      </header>

      <div className="mt-10">
        <DocList docs={projects} />
      </div>
    </>
  )
}
