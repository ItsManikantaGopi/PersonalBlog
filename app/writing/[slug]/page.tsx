import type { Metadata } from 'next'
import { notFound } from 'next/navigation'
import { getDoc, listSlugs } from '@/lib/content'
import { DocPage } from '@/components/doc-page'

type Params = { params: Promise<{ slug: string }> }

export function generateStaticParams() {
  return listSlugs('posts').map((slug) => ({ slug }))
}

export async function generateMetadata({ params }: Params): Promise<Metadata> {
  const { slug } = await params
  const doc = await getDoc('posts', slug)
  if (!doc) return {}

  return {
    title: doc.title,
    description: doc.summary,
    openGraph: {
      type: 'article',
      title: doc.title,
      description: doc.summary,
      url: `/writing/${slug}/`,
      publishedTime: doc.date,
    },
  }
}

export default async function PostPage({ params }: Params) {
  const { slug } = await params
  const doc = await getDoc('posts', slug)
  if (!doc) notFound()

  return <DocPage doc={doc} />
}
