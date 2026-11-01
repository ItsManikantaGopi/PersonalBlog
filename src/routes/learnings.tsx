import { createFileRoute } from "@tanstack/react-router";
import { Tabs, TabsContent, TabsList, TabsTrigger } from "@/components/ui/tabs";
import { profile } from "@/data/portfolio";

const siteUrl = profile.site;
const pageTitle = "Learnings & resources — Manikanta Gopi";
const pageDescription =
  "Free interview prep kit: story-based Go and DSA lessons, 32 animated system design walkthroughs, a 6-week plan, spaced review and timed mock rounds.";
const prepKitUrl = "/learnings/interview-prep/index.html";

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

const linkClass =
  "inline-flex min-h-10 items-center justify-center whitespace-nowrap rounded-md border border-border bg-background/50 px-4 py-2 font-mono text-xs font-medium transition-all hover:border-primary hover:text-primary focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary";

const kitFeatures = [
  [
    "Go + DSA stories",
    "155 problems explained as short stories with step-by-step animations and Go solutions.",
  ],
  [
    "System design",
    "32 animated designs: foundations (replication, Raft, Kafka), classic questions and platform work.",
  ],
  [
    "6-week plan",
    "A daily plan that mixes Go, DSA and design lessons, with spaced-repetition review.",
  ],
  [
    "Mock rounds",
    "Timed 42-minute design mocks with phase beeps, self-scoring and a progress log.",
  ],
] as const;

function Learnings() {
  return (
    <div className="min-h-screen bg-background">
      <header className="sticky top-0 z-50 border-b border-border bg-background/90 backdrop-blur">
        <div className="mx-auto flex w-full max-w-6xl items-center justify-between gap-4 px-6 py-4">
          <a href="/" className="shrink-0 font-mono text-sm font-medium tracking-tight">
            <span className="text-primary">~/</span>manikanta
          </a>
          <a
            href="/"
            className="font-mono text-[11px] uppercase tracking-widest text-muted-foreground transition-colors hover:text-foreground"
          >
            ← Portfolio
          </a>
        </div>
      </header>

      <main className="mx-auto w-full max-w-6xl px-6 py-12 md:py-16">
        <span className="rule-label">Resources / Learnings</span>
        <h1 className="mt-3 text-3xl font-semibold tracking-tight md:text-4xl">Learnings</h1>
        <p className="mt-3 max-w-2xl text-muted-foreground">
          Things I built while preparing for backend and platform interviews, shared so anyone can
          use them.
        </p>

        <Tabs defaultValue="interview-prep" className="mt-8">
          <TabsList>
            <TabsTrigger value="interview-prep">Interview prep</TabsTrigger>
            <TabsTrigger value="writing">Writing</TabsTrigger>
          </TabsList>

          <TabsContent value="interview-prep" className="mt-6">
            <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
              {kitFeatures.map(([title, detail]) => (
                <div key={title} className="rounded-lg border border-border p-4">
                  <h2 className="font-mono text-sm font-medium">{title}</h2>
                  <p className="mt-1 text-sm text-muted-foreground">{detail}</p>
                </div>
              ))}
            </div>
            <div className="mt-5 flex flex-wrap items-center gap-3">
              <a href={prepKitUrl} target="_blank" rel="noreferrer" className={linkClass}>
                Open full screen ↗
              </a>
              <span className="text-xs text-muted-foreground">
                Progress is saved in your browser only. Export it from Progress → Settings.
              </span>
            </div>
            <iframe
              src={prepKitUrl}
              title="Gopher Prep: Go, DSA and system design interview prep"
              loading="lazy"
              className="mt-5 h-[85vh] min-h-[640px] w-full rounded-lg border border-border bg-background"
            />
          </TabsContent>

          <TabsContent value="writing" className="mt-6">
            <p className="max-w-2xl text-muted-foreground">
              Longer write-ups on backend systems, Kubernetes and cost work live on Medium.
            </p>
            <a
              href={profile.medium}
              target="_blank"
              rel="noreferrer"
              className={`${linkClass} mt-4`}
            >
              Read on Medium ↗
            </a>
          </TabsContent>
        </Tabs>
      </main>
    </div>
  );
}
