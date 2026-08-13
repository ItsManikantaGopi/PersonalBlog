import type { Metadata } from 'next'
import { listDocs } from '@/lib/content'
import { DocList } from '@/components/ui'

export const metadata: Metadata = {
  title: 'Writing',
  description:
    'Notes on backend systems, Kubernetes, queues and the parts of production that only teach you once.',
}

export default async function WritingPage() {
  const posts = await listDocs('posts')

  return (
    <>
      <header>
        <h1 className="text-2xl font-semibold tracking-tight">Writing</h1>
        <p className="mt-3 max-w-prose text-[0.975rem] leading-relaxed text-text-muted">
          Mostly things I had to work out the hard way and wanted written down before I forgot the
          reasoning.
        </p>
      </header>

      <div className="mt-10">
        <DocList docs={posts} />
      </div>
    </>
  )
}
