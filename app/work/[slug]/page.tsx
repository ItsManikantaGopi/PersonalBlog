import type { Metadata } from 'next'
import { notFound } from 'next/navigation'
import { getDoc, listSlugs } from '@/lib/content'
import { DocPage } from '@/components/doc-page'

type Params = { params: Promise<{ slug: string }> }

export function generateStaticParams() {
  return listSlugs('projects').map((slug) => ({ slug }))
}

export async function generateMetadata({ params }: Params): Promise<Metadata> {
  const { slug } = await params
  const doc = await getDoc('projects', slug)
  if (!doc) return {}

  return {
    title: doc.title,
    description: doc.summary,
    openGraph: {
      type: 'article',
      title: doc.title,
      description: doc.summary,
      url: `/work/${slug}/`,
    },
  }
}

export default async function ProjectPage({ params }: Params) {
  const { slug } = await params
  const doc = await getDoc('projects', slug)
  if (!doc) notFound()

  return <DocPage doc={doc} />
}
