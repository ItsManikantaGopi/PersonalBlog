'use client'

import { useEffect } from 'react'

/**
 * Renders any `.mermaid-block` the content pipeline left behind.
 *
 * mermaid is a heavy dependency, so it is imported dynamically and only when a
 * page actually contains a diagram — pages without one never load the chunk.
 */
export function MermaidRenderer() {
  useEffect(() => {
    const blocks = Array.from(document.querySelectorAll<HTMLElement>('.mermaid-block'))
    if (blocks.length === 0) return

    let cancelled = false

    async function render() {
      const mermaid = (await import('mermaid')).default
      if (cancelled) return

      const isDark =
        document.documentElement.dataset.theme === 'dark' ||
        (!document.documentElement.dataset.theme &&
          window.matchMedia('(prefers-color-scheme: dark)').matches)

      // Read the live palette so diagrams match the page rather than shipping
      // mermaid's own idea of a dark theme, whose greys fight our background.
      const css = getComputedStyle(document.documentElement)
      const token = (name: string, fallback: string) =>
        css.getPropertyValue(name).trim() || fallback

      const bg = token('--bg', isDark ? '#0e0e0d' : '#fbfbfa')
      const surface = token('--bg-subtle', isDark ? '#17171a' : '#f2f2f0')
      const border = token('--border-strong', isDark ? '#3d3d43' : '#cfcfc8')
      const text = token('--text', isDark ? '#ededea' : '#1a1a18')
      const muted = token('--text-muted', isDark ? '#a3a39c' : '#5f5f58')

      mermaid.initialize({
        startOnLoad: false,
        theme: 'base',
        darkMode: isDark,
        fontFamily: 'var(--font-mono-stack)',
        themeVariables: {
          fontSize: '13px',
          background: bg,
          primaryColor: surface,
          primaryTextColor: text,
          primaryBorderColor: border,
          secondaryColor: surface,
          tertiaryColor: bg,
          // Subgraph containers — the main offender in mermaid's stock themes.
          clusterBkg: bg,
          clusterBorder: border,
          lineColor: muted,
          textColor: text,
          nodeBorder: border,
          mainBkg: surface,
          edgeLabelBackground: bg,
        },
      })

      for (const [i, block] of blocks.entries()) {
        const encoded = block.dataset.mermaid
        if (!encoded) continue

        let source: string
        try {
          source = atob(encoded)
        } catch {
          continue
        }

        try {
          const { svg } = await mermaid.render(`mermaid-${i}-${Date.now()}`, source)
          if (cancelled) return
          block.innerHTML = svg
          block.dataset.rendered = 'true'
        } catch {
          // A diagram that won't parse shows its source rather than vanishing.
          const pre = document.createElement('pre')
          pre.textContent = source
          block.replaceChildren(pre)
          block.dataset.rendered = 'error'
        }
      }
    }

    void render()

    // Diagram colours are baked into the SVG at render time, so a theme change
    // means redrawing them. Watch both the explicit toggle and the OS setting.
    const rerender = () => {
      for (const block of blocks) block.dataset.rendered = 'false'
      void render()
    }

    const observer = new MutationObserver(rerender)
    observer.observe(document.documentElement, {
      attributes: true,
      attributeFilter: ['data-theme'],
    })

    const media = window.matchMedia('(prefers-color-scheme: dark)')
    media.addEventListener('change', rerender)

    return () => {
      cancelled = true
      observer.disconnect()
      media.removeEventListener('change', rerender)
    }
  }, [])

  return null
}
