'use client'

import { useEffect, useState } from 'react'

type Mode = 'system' | 'light' | 'dark'

const STORAGE_KEY = 'theme'

function apply(mode: Mode) {
  const root = document.documentElement
  if (mode === 'system') {
    root.removeAttribute('data-theme')
  } else {
    root.setAttribute('data-theme', mode)
  }
}

export function ThemeToggle() {
  // `system` until the effect reads storage, so server and client markup agree.
  const [mode, setMode] = useState<Mode>('system')
  const [mounted, setMounted] = useState(false)

  useEffect(() => {
    const stored = localStorage.getItem(STORAGE_KEY) as Mode | null
    if (stored === 'light' || stored === 'dark') setMode(stored)
    setMounted(true)
  }, [])

  function cycle() {
    // system → dark → light → system
    const next: Mode = mode === 'system' ? 'dark' : mode === 'dark' ? 'light' : 'system'
    setMode(next)
    apply(next)
    if (next === 'system') localStorage.removeItem(STORAGE_KEY)
    else localStorage.setItem(STORAGE_KEY, next)
  }

  const label =
    mode === 'system' ? 'Theme: follow system' : mode === 'dark' ? 'Theme: dark' : 'Theme: light'

  return (
    <button
      type="button"
      onClick={cycle}
      aria-label={label}
      title={label}
      className="grid size-8 place-items-center rounded-md border border-border-base text-text-muted transition-colors hover:border-border-strong hover:text-text"
    >
      {/* Render a neutral glyph until mounted so there's no hydration mismatch. */}
      {!mounted || mode === 'system' ? <MonitorIcon /> : mode === 'dark' ? <MoonIcon /> : <SunIcon />}
    </button>
  )
}

function iconProps() {
  return {
    width: 15,
    height: 15,
    viewBox: '0 0 24 24',
    fill: 'none',
    stroke: 'currentColor',
    strokeWidth: 1.8,
    strokeLinecap: 'round' as const,
    strokeLinejoin: 'round' as const,
    'aria-hidden': true,
  }
}

function MonitorIcon() {
  return (
    <svg {...iconProps()}>
      <rect x="2" y="3" width="20" height="14" rx="2" />
      <path d="M8 21h8M12 17v4" />
    </svg>
  )
}

function MoonIcon() {
  return (
    <svg {...iconProps()}>
      <path d="M21 12.8A9 9 0 1 1 11.2 3a7 7 0 0 0 9.8 9.8Z" />
    </svg>
  )
}

function SunIcon() {
  return (
    <svg {...iconProps()}>
      <circle cx="12" cy="12" r="4" />
      <path d="M12 2v2m0 16v2M2 12h2m16 0h2M4.9 4.9l1.4 1.4m11.4 11.4 1.4 1.4M19.1 4.9l-1.4 1.4M6.3 17.7l-1.4 1.4" />
    </svg>
  )
}

/**
 * Sets the theme attribute before first paint so a dark-mode visitor never sees
 * a white flash. Injected as a blocking inline script in the document head.
 */
export const themeScript = `
(function(){
  try {
    var m = localStorage.getItem('${STORAGE_KEY}');
    if (m === 'light' || m === 'dark') {
      document.documentElement.setAttribute('data-theme', m);
    }
  } catch (e) {}
})();
`.trim()
