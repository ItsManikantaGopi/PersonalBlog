import path from 'node:path'
import type { NextConfig } from 'next'

/**
 * Static export. `out/` is a plain folder of HTML — deployable to GitHub Pages,
 * S3 + CloudFront, Vercel, or anything that serves files.
 *
 * BASE_PATH matters when the site is served from a subpath, which is what
 * GitHub Pages does for a project repo (`/PersonalBlog`). Leave it unset for a
 * custom domain or a `<user>.github.io` repo, where the site sits at the root.
 */
const basePath = process.env.BASE_PATH ?? ''

const nextConfig: NextConfig = {
  // Pin the workspace root. Without this, Turbopack walks up the filesystem and
  // finds an unrelated lockfile in the parent directory.
  turbopack: { root: path.resolve(import.meta.dirname) },
  output: 'export',
  basePath: basePath || undefined,
  // Trailing slashes keep directory-style URLs working on static hosts that
  // don't rewrite extensionless paths.
  trailingSlash: true,
  images: {
    // No image optimization server exists in a static export.
    unoptimized: true,
  },
  env: {
    NEXT_PUBLIC_BASE_PATH: basePath,
  },
}

export default nextConfig
