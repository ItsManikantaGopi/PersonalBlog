import { social, site } from '@/lib/profile'

const links = [
  { label: 'GitHub', href: social.github },
  { label: 'LinkedIn', href: social.linkedin },
  { label: 'Email', href: `mailto:${social.email}` },
]

export function SiteFooter() {
  return (
    <footer className="mt-24 border-t border-border-base">
      <div className="mx-auto flex max-w-3xl flex-col gap-3 px-5 py-8 text-sm text-text-muted sm:flex-row sm:items-center sm:justify-between">
        <p className="font-mono text-xs">
          © {new Date().getFullYear()} {site.name} · {site.location}
        </p>
        <nav aria-label="Elsewhere" className="flex gap-4">
          {links.map((link) => (
            <a
              key={link.label}
              href={link.href}
              className="transition-colors hover:text-text"
              {...(link.href.startsWith('http')
                ? { target: '_blank', rel: 'noreferrer noopener' }
                : {})}
            >
              {link.label}
            </a>
          ))}
        </nav>
      </div>
    </footer>
  )
}
