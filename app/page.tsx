import Link from 'next/link'

export default function Home() {
  return (
    <div className="container">
      <div style={{ paddingTop: '4rem' }}>
        <h1 style={{ fontSize: '3rem', fontWeight: 700, marginBottom: '0.5rem' }}>
          Manikanta Gopi
        </h1>
        <p style={{ fontSize: '1.25rem', color: 'var(--gray-500)', marginBottom: '2rem' }}>
          Software Engineer
        </p>
        
        <p style={{ fontSize: '1.125rem', color: 'var(--gray-600)', maxWidth: '500px', marginBottom: '3rem' }}>
          Building backend systems, cloud infrastructure, and event-driven architectures. 
          Writing about technology, sharing my hobbies, and documenting books I read.
        </p>

        <div style={{ display: 'flex', gap: '2rem' }}>
          <Link href="/posts" style={{ color: 'var(--black)', fontWeight: 500 }}>
            Read Posts →
          </Link>
          <Link href="/hobbies" style={{ color: 'var(--black)', fontWeight: 500 }}>
            View Hobbies →
          </Link>
          <Link href="/books" style={{ color: 'var(--black)', fontWeight: 500 }}>
            Books I Read →
          </Link>
        </div>
      </div>
    </div>
  )
}
