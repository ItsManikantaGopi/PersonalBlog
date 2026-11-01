import { createFileRoute } from "@tanstack/react-router";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { profile } from "@/data/portfolio";
import { MobileNav } from "@/components/mobile-nav";

const siteUrl = profile.site;
const pageTitle = "Learnings & resources — Manikanta Gopi";
const pageDescription =
  "Upskill in 30 minutes a day: Go, data structures and 32 animated system designs, with a daily focus loop and spaced review.";
const kitUrl = "/learnings/upskill/index.html";

export const Route = createFileRoute("/learnings")({
  head: () => ({
    meta: [
      { title: pageTitle },
      { name: "description", content: pageDescription },
      { property: "og:title", content: pageTitle },
      { property: "og:description", content: pageDescription },
      { property: "og:url", content: `${siteUrl}/learnings` },
      { property: "og:image", content: `${siteUrl}/og-image.png` },
      { name: "twitter:card", content: "summary_large_image" },
    ],
    links: [{ rel: "canonical", href: `${siteUrl}/learnings` }],
  }),
  component: Learnings,
});

const nav = [
  { href: "/#work", label: "Work" },
  { href: "/#products", label: "Products" },
  { href: "/#consulting", label: "Services" },
  { href: "/#experience", label: "Experience" },
  { href: "/learnings", label: "Learnings", current: true },
  { href: "/#contact", label: "Contact" },
];

const primaryCtaClass =
  "inline-flex min-h-11 items-center justify-center whitespace-nowrap rounded-md bg-foreground px-5 py-2.5 font-mono text-sm font-medium text-background shadow-sm transition-all hover:-translate-y-0.5 hover:opacity-90 hover:shadow-md focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary focus-visible:ring-offset-2 focus-visible:ring-offset-background";

const secondaryCtaClass =
  "inline-flex min-h-11 items-center justify-center whitespace-nowrap rounded-md border border-border bg-background/50 px-5 py-2.5 font-mono text-sm font-medium transition-all hover:-translate-y-0.5 hover:border-foreground hover:bg-surface hover:text-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary focus-visible:ring-offset-2 focus-visible:ring-offset-background";

const tabTriggerClass =
  "rounded-none border-b-2 border-transparent bg-transparent px-0 pb-3 font-mono text-[11px] uppercase tracking-widest text-muted-foreground shadow-none transition-colors hover:text-foreground data-[state=active]:border-foreground data-[state=active]:bg-transparent data-[state=active]:text-foreground data-[state=active]:shadow-none";

const modules = [
  {
    tab: "viz",
    index: "01",
    title: "DSA stories",
    detail:
      "155 problems, each told as a short story with a step-by-step animation and a Go (or Python) solution.",
    meta: "155 problems · 18 patterns",
  },
  {
    tab: "sysd",
    index: "02",
    title: "System design",
    detail:
      "32 animated designs: replication, Raft, Kafka and database internals, the classic questions, and platform work like autoscaling and zero-downtime migrations.",
    meta: "32 designs · playbook · mocks",
  },
  {
    tab: "go",
    index: "03",
    title: "Go basics",
    detail:
      "14 short lessons from syntax to goroutines, channels and worker pools, each with an animation.",
    meta: "14 lessons",
  },
  {
    tab: "plan",
    index: "04",
    title: "6-week plan",
    detail:
      "A daily plan that mixes Go, DSA and design lessons, with spaced-repetition review so things stick.",
    meta: "Daily tasks · spaced review",
  },
  {
    tab: "practice",
    index: "05",
    title: "Practice rounds",
    detail: "Timed coding and 42-minute design mocks with phase timers, self-scoring and a log.",
    meta: "Timers · rubric · log",
  },
  {
    tab: "faang",
    index: "06",
    title: "FAANG track",
    detail:
      "A 12-week extension: advanced patterns, a practice ladder and a behavioral story bank.",
    meta: "12 weeks",
  },
];

function Learnings() {
  return (
    <div className="min-h-screen bg-background">
      <header className="sticky top-0 z-50 border-b border-border bg-background/90 backdrop-blur">
        <div className="mx-auto flex w-full max-w-5xl items-center justify-between gap-4 px-6 py-4">
          <a href="/" className="shrink-0 font-mono text-sm font-medium tracking-tight">
            <span className="text-primary">~/</span>manikanta
          </a>
          <nav className="hidden gap-5 md:flex">
            {nav.map((item) => (
              <a
                key={item.href}
                href={item.href}
                aria-current={item.current ? "page" : undefined}
                className={`${item.current ? "text-foreground" : "text-muted-foreground"} font-mono text-[11px] uppercase tracking-widest transition-colors hover:text-foreground`}
              >
                {item.label}
              </a>
            ))}
          </nav>
          <MobileNav
            items={[{ href: "/", label: "Home" }, ...nav, { href: "/resume.pdf", label: "Resume" }]}
          />
        </div>
      </header>

      <main>
        <section className="hero-glow">
          <div className="mx-auto w-full max-w-5xl px-6 pb-12 pt-16 md:pb-16 md:pt-24">
            <span className="rule-label">Resources / Learnings</span>
            <h1 className="mt-4 max-w-3xl text-4xl font-semibold tracking-tight md:text-5xl">
              Learnings
            </h1>
            <p className="mt-4 max-w-2xl text-muted-foreground">
              A system I use to keep my backend and systems skills sharp, shared so anyone can use
              it. Free, no sign-up, progress stays in your browser.
            </p>
          </div>
        </section>

        <div className="mx-auto w-full max-w-5xl px-6 py-12 md:py-16">
          <Tabs defaultValue="upskill">
            <TabsList className="h-auto w-full justify-start gap-8 rounded-none border-b border-border bg-transparent p-0">
              <TabsTrigger value="upskill" className={tabTriggerClass}>
                Upskill
              </TabsTrigger>
              <TabsTrigger value="writing" className={tabTriggerClass}>
                Writing
              </TabsTrigger>
            </TabsList>

            <TabsContent value="upskill" className="mt-10">
              <div className="flex flex-col gap-6 md:flex-row md:items-end md:justify-between">
                <div className="max-w-2xl">
                  <h2 className="text-3xl font-semibold tracking-tight md:text-4xl">
                    Upskill in 30 minutes a day
                  </h2>
                  <p className="mt-3 text-muted-foreground">
                    Each day: learn one lesson, practise one problem, recall what is fading. Go,
                    data structures and system design, told as short animated stories.
                  </p>
                </div>
                <div className="flex flex-wrap gap-3">
                  <a href={kitUrl} className={primaryCtaClass}>
                    Start today's loop →
                  </a>
                  <a href={`${kitUrl}?tab=sysd`} className={secondaryCtaClass}>
                    System design
                  </a>
                </div>
              </div>

              <div className="mt-10 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
                {modules.map((m) => (
                  <a
                    key={m.tab}
                    href={`${kitUrl}?tab=${m.tab}`}
                    className="panel group flex flex-col p-5 transition-all hover:-translate-y-0.5 hover:border-foreground"
                  >
                    <span className="font-mono text-xs text-muted-foreground">{m.index}</span>
                    <h3 className="mt-3 text-lg font-semibold tracking-tight group-hover:text-foreground">
                      {m.title}
                    </h3>
                    <p className="mt-2 flex-1 text-sm text-muted-foreground">{m.detail}</p>
                    <span className="mt-4 font-mono text-[11px] uppercase tracking-widest text-muted-foreground">
                      {m.meta} <span className="text-foreground">→</span>
                    </span>
                  </a>
                ))}
              </div>

              <p className="mt-8 font-mono text-xs text-muted-foreground">
                Progress is saved in your browser only. Export or import it from Progress → Settings
                inside the app.
              </p>
            </TabsContent>

            <TabsContent value="writing" className="mt-10">
              <h2 className="text-3xl font-semibold tracking-tight md:text-4xl">Writing</h2>
              <p className="mt-3 max-w-2xl text-muted-foreground">
                Longer write-ups on backend systems, Kubernetes and cost work live on Medium.
              </p>
              <a
                href={profile.medium}
                target="_blank"
                rel="noreferrer"
                className={`${secondaryCtaClass} mt-6`}
              >
                Read on Medium ↗
              </a>
            </TabsContent>
          </Tabs>
        </div>
      </main>

      <footer className="border-t border-border">
        <div className="mx-auto flex w-full max-w-5xl flex-wrap items-center justify-between gap-3 px-6 py-8">
          <a href="/" className="font-mono text-xs text-muted-foreground hover:text-foreground">
            ← Back to portfolio
          </a>
          <a
            href={`mailto:${profile.email}`}
            className="font-mono text-xs text-muted-foreground transition-colors hover:text-foreground"
          >
            {profile.email}
          </a>
        </div>
      </footer>
    </div>
  );
}
