import Link from 'next/link'

export default function NotFound() {
  return (
    <div className="py-16">
      <p className="font-mono text-sm text-text-faint">404</p>
      <h1 className="mt-2 text-2xl font-semibold tracking-tight">No such page</h1>
      <p className="mt-3 text-[0.975rem] text-text-muted">
        The link is broken or the page has moved.
      </p>
      <div className="mt-6 flex gap-4 font-mono text-xs">
        <Link href="/" className="text-accent hover:underline">
          Home
        </Link>
        <Link href="/work/" className="text-accent hover:underline">
          Work
        </Link>
        <Link href="/writing/" className="text-accent hover:underline">
          Writing
        </Link>
      </div>
    </div>
  )
}
