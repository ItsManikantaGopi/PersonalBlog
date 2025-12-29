import { notFound } from 'next/navigation'
import { getPostBySlug, getAllPostSlugs } from '@/lib/posts'
import Link from 'next/link'

export async function generateStaticParams() {
  const slugs = getAllPostSlugs()
  return slugs.map((slug) => ({ slug }))
}

export default async function PostPage({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params
  const post = await getPostBySlug(slug)

  if (!post) {
    notFound()
  }

  return (
    <div className="container">
      <Link href="/posts" style={{ fontSize: '0.875rem', color: 'var(--gray-500)', display: 'block', marginBottom: '2rem' }}>
        ← Back to posts
      </Link>
      
      <article>
        <header style={{ marginBottom: '2rem' }}>
          <h1 style={{ fontSize: '2rem', fontWeight: 600, marginBottom: '0.5rem' }}>{post.title}</h1>
          <p style={{ color: 'var(--gray-500)' }}>{post.date}</p>
        </header>
        
        <div 
          className="prose"
          dangerouslySetInnerHTML={{ __html: post.content || '' }} 
        />
      </article>
    </div>
  )
}
