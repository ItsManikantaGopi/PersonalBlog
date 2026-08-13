# Portfolio and engineering notes

Personal site of Manikanta Gopi — case studies of systems I've built or run, plus writing.
Next.js with a static export, so the output is a plain folder of HTML.

```bash
npm install
npm run dev        # http://localhost:3000
npm run build      # static site in out/
npm run start      # serve the built output locally
npm run typecheck
```

## Layout

```
app/                    routes: / · /work · /writing · /about
├── work/[slug]/        case studies
├── writing/[slug]/     posts
├── sitemap.ts          generated from the content directory
└── globals.css         palette tokens and long-form styles
components/             header, footer, theme toggle, listings, mermaid renderer
content/
├── projects/           case studies (markdown)
└── posts/              blog posts (markdown)
lib/
├── content.ts          markdown → HTML at build time
└── profile.ts          bio, roles, skills, stats — single source of truth
```

## Adding content

Drop a `.md` file into `content/posts/` or `content/projects/`. The filename is the URL slug.

```markdown
---
title: What the thing is
summary: One or two sentences. Used in listings and as the meta description.
date: '2026-08-13'          # required; drives ordering and the sitemap
period: '2025 – 2026'       # projects only, shown instead of the date
role: What I did on it      # projects only
featured: true              # pin to the top and surface on the home page
weight: 30                  # ordering within featured; lower first, default 100
draft: true                 # hide from listings without deleting the file
tags: ['kubernetes']
stack: ['Go', 'Redis']      # rendered as chips
links:
  - label: 'github.com/user/repo'
    href: 'https://github.com/user/repo'
---
```

Supported in the body: GitHub-flavoured markdown, tables, footnotes, syntax-highlighted
code fences, and `mermaid` fences for diagrams.

- **Code highlighting** is done at build time by Shiki via `rehype-pretty-code`, which emits
  both a light and a dark theme as CSS variables. No highlighting runs in the browser.
- **Mermaid diagrams** render client-side. The library is dynamically imported, so pages
  without a diagram never download it, and diagrams redraw when the theme changes.
- **Headings** get anchor links automatically. A page with three or more `##` headings gets
  a table of contents.

## Theming

The palette lives as CSS custom properties in `app/globals.css`. Light is defined on bare
`:root`; dark is redefined twice, once under `prefers-color-scheme` and once under
`[data-theme="dark"]`, so the toggle wins in both directions and the system default works
with no toggle at all. An inline script in `app/layout.tsx` applies the stored preference
before first paint to avoid a flash.

The toggle cycles system → dark → light.

## Deployment

`.github/workflows/deploy.yml` builds on every push to `main` and publishes to GitHub Pages.

Because a project repository is served from a subpath, the workflow sets `BASE_PATH=/PersonalBlog`
so links and assets are prefixed correctly. Two things to change if the site moves:

1. Remove the `BASE_PATH` env var from the workflow (a custom domain or a `<user>.github.io`
   repository serves from the root).
2. Update `site.url` in `lib/profile.ts` — it's used for canonical URLs, the sitemap and
   Open Graph tags.

The output is a static folder, so any host works: S3 and CloudFront, Vercel, Netlify, or
`npx serve out`.

## Notes on the content

Company work is written at the architecture level. No internal ticket identifiers, hostnames,
bucket names or configuration values appear anywhere in this repository. Figures quoted in the
case studies come from repository history, pull-request records or measurements — if a number
couldn't be defended in a conversation, it isn't here.

## Previous version

This repository previously held a Flutter web portfolio. That code is preserved on the
`legacy/flutter-portfolio` branch and in the history before the Next.js rewrite.
