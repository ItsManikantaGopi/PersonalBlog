import type { MetadataRoute } from 'next'
import { listDocs } from '@/lib/content'
import { site } from '@/lib/profile'

export const dynamic = 'force-static'

export default async function sitemap(): Promise<MetadataRoute.Sitemap> {
  const [projects, posts] = await Promise.all([listDocs('projects'), listDocs('posts')])
  const base = site.url.replace(/\/$/, '')

  const staticRoutes = ['', '/work', '/writing', '/about'].map((route) => ({
    url: `${base}${route}/`,
    lastModified: new Date(),
    changeFrequency: 'monthly' as const,
    priority: route === '' ? 1 : 0.8,
  }))

  const docRoutes = [
    ...projects.map((doc) => ({ doc, prefix: '/work' })),
    ...posts.map((doc) => ({ doc, prefix: '/writing' })),
  ].map(({ doc, prefix }) => ({
    url: `${base}${prefix}/${doc.slug}/`,
    lastModified: new Date(`${doc.date}T00:00:00Z`),
    changeFrequency: 'yearly' as const,
    priority: 0.6,
  }))

  return [...staticRoutes, ...docRoutes]
}
