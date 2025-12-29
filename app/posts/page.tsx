import Link from 'next/link'
import { getAllPosts } from '@/lib/posts'

export default function PostsPage() {
  const posts = getAllPosts()

  return (
    <div className="container">
      <div className="page-header">
        <h1 className="page-title">Posts</h1>
        <p className="page-description">Thoughts on technology, engineering, and more.</p>
      </div>

      {posts.length === 0 ? (
        <p style={{ color: 'var(--gray-500)' }}>
          No posts yet. Add markdown files to <code>content/posts/</code> to get started.
        </p>
      ) : (
        <div>
          {posts.map((post) => (
            <Link key={post.slug} href={`/posts/${post.slug}`}>
              <article className="card">
                <h2 className="card-title">{post.title}</h2>
                <p className="card-meta">{post.date}</p>
                <p className="card-excerpt">{post.excerpt}</p>
              </article>
            </Link>
          ))}
        </div>
      )}
    </div>
  )
}
