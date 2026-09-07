import { createFileRoute } from "@tanstack/react-router";
import {
  profile,
  stats,
  results,
  projects,
  roles,
  skillGroups,
  education,
  writing,
  serviceOffer,
  problems,
} from "@/data/portfolio";

export const Route = createFileRoute("/")({
  head: () => ({
    meta: [
      { title: "Manikanta Gopi — Senior Backend & Platform Engineer" },
      {
        name: "description",
        content:
          "Senior backend and platform engineering across architecture, infrastructure cost, Kubernetes, cloud migrations and production reliability.",
      },
      { property: "og:title", content: "Manikanta Gopi — Senior Backend & Platform Engineer" },
      {
        property: "og:description",
        content:
          "Production backend systems, infrastructure cost optimization, cloud migrations and focused technical consulting.",
      },
      { property: "og:type", content: "profile" },
      { name: "twitter:card", content: "summary_large_image" },
    ],
  }),
  component: Portfolio,
});

const nav = [
  { href: "#problems", label: "Problems" },
  { href: "#results", label: "Results" },
  { href: "#work", label: "Work" },
  { href: "#consulting", label: "Consulting" },
  { href: "#experience", label: "Experience" },
  { href: "#writing", label: "Writing" },
  { href: "#contact", label: "Contact" },
];

function Section({
  id,
  index,
  title,
  lead,
  children,
}: {
  id: string;
  index: string;
  title: string;
  lead?: string;
  children: React.ReactNode;
}) {
  return (
    <section id={id} className="border-t border-border py-20 md:py-28">
      <div className="mx-auto w-full max-w-5xl px-6">
        <div className="mb-10 flex flex-col gap-3 md:mb-14">
          <span className="rule-label">
            {index} / {title}
          </span>
          <h2 className="text-3xl font-semibold tracking-tight md:text-4xl">{title}</h2>
          {lead ? <p className="max-w-2xl text-muted-foreground">{lead}</p> : null}
        </div>
        {children}
      </div>
    </section>
  );
}

function Tag({ children }: { children: React.ReactNode }) {
  return (
    <span className="rounded-full border border-border bg-muted px-2.5 py-1 font-mono text-[11px] text-muted-foreground">
      {children}
    </span>
  );
}

function Portfolio() {
  return (
    <div className="min-h-screen bg-background">
      <header className="sticky top-0 z-50 border-b border-border bg-background/85 backdrop-blur">
        <div className="mx-auto flex w-full max-w-5xl items-center justify-between px-6 py-4">
          <a href="#top" className="font-mono text-sm font-medium tracking-tight">
            <span className="text-primary">~/</span>manikanta
          </a>
          <nav className="hidden gap-5 md:flex">
            {nav.map((item) => (
              <a
                key={item.href}
                href={item.href}
                className="font-mono text-[11px] uppercase tracking-widest text-muted-foreground transition-colors hover:text-foreground"
              >
                {item.label}
              </a>
            ))}
          </nav>
          <a
            href={`mailto:${profile.email}?subject=Consulting%20request`}
            className="rounded-md bg-primary px-3 py-1.5 font-mono text-xs font-medium text-primary-foreground transition-opacity hover:opacity-90"
          >
            Work with me
          </a>
        </div>
      </header>

      <main id="top">
        <section className="hero-glow">
          <div className="mx-auto w-full max-w-5xl px-6 pb-20 pt-16 md:pb-28 md:pt-24">
            <div className="grid items-center gap-10 md:grid-cols-[250px_minmax(0,1fr)] lg:grid-cols-[300px_minmax(0,1fr)] lg:gap-16">
              <div className="order-2 mx-auto w-full max-w-[280px] md:order-1 md:max-w-none">
                <div className="relative mx-auto w-full max-w-[280px]">
                  <div
                    className="absolute -inset-3 rounded-full border border-primary/20 bg-primary/5 blur-sm"
                    aria-hidden="true"
                  />
                  <div className="relative aspect-square overflow-hidden rounded-full border-2 border-border bg-surface shadow-xl">
                    <img
                      src={profile.photo}
                      alt={profile.name}
                      className="h-full w-full object-cover object-center"
                      loading="eager"
                      fetchPriority="high"
                    />
                  </div>
                  <div className="mt-5 text-center">
                    <p className="font-mono text-[10px] uppercase tracking-widest text-primary">
                      Backend · Platform · Infrastructure
                    </p>
                    <p className="mt-1 text-xs text-muted-foreground">Production systems, cost and reliability.</p>
                  </div>
                </div>
              </div>

              <div className="order-1 md:order-2">
                <span className="rule-label">
                  {profile.role} · {profile.location}
                </span>
                <h1 className="mt-5 max-w-4xl text-4xl font-semibold leading-[1.04] tracking-tight md:text-6xl">
                  {profile.name}
                  <span className="block text-primary">{profile.tagline}</span>
                </h1>
                <div className="mt-8 max-w-3xl space-y-4 text-base leading-relaxed text-muted-foreground md:text-lg">
                  {profile.intro.map((p) => (
                    <p key={p.slice(0, 24)}>{p}</p>
                  ))}
                </div>
                <div className="mt-10 flex flex-wrap gap-3">
                  <a
                    href={`mailto:${profile.email}?subject=Consulting%20request`}
                    className="rounded-md bg-primary px-5 py-2.5 font-mono text-sm font-medium text-primary-foreground transition-opacity hover:opacity-90"
                  >
                    Discuss a problem →
                  </a>
                  <a
                    href="#results"
                    className="rounded-md border border-border px-5 py-2.5 font-mono text-sm transition-colors hover:border-primary hover:text-primary"
                  >
                    See the results
                  </a>
                </div>
                <p className="mt-5 font-mono text-[11px] uppercase tracking-widest text-muted-foreground">
                  Available for focused consulting conversations · Mon–Fri · 10:30–19:30 IST
                </p>
              </div>
            </div>

            <dl className="mt-16 grid grid-cols-2 gap-px overflow-hidden rounded-lg border border-border bg-border md:grid-cols-4">
              {stats.map((s) => (
                <div key={s.label} className="bg-surface p-5">
                  <dt className="font-mono text-2xl font-semibold text-primary md:text-3xl">
                    {s.value}
                  </dt>
                  <dd className="mt-2 text-sm font-medium">{s.label}</dd>
                  <dd className="mt-1 text-xs text-muted-foreground">{s.detail}</dd>
                </div>
              ))}
            </dl>
          </div>
        </section>

        <Section
          id="problems"
          index="01"
          title="Problems I solve"
          lead="The useful question is not which tools I know. It is which engineering problem I can help you make clearer."
        >
          <div className="grid gap-4 md:grid-cols-2">
            {problems.map((problem) => (
              <article key={problem.title} className="panel p-6">
                <h3 className="text-lg font-semibold tracking-tight">{problem.title}</h3>
                <p className="mt-3 text-sm leading-relaxed text-muted-foreground">{problem.summary}</p>
                <div className="mt-5 border-l border-primary/40 pl-4">
                  <p className="font-mono text-xs uppercase tracking-widest text-primary">Proof</p>
                  <p className="mt-2 text-sm leading-relaxed">{problem.evidence}</p>
                </div>
              </article>
            ))}
          </div>
        </Section>

        <Section
          id="results"
          index="02"
          title="Results"
          lead="The strongest proof is what changed after the engineering work — cost, reliability, capacity or operational control."
        >
          <div className="grid gap-4 sm:grid-cols-2">
            {results.map((result) => (
              <article key={result.label} className="panel p-6">
                <p className="font-mono text-2xl font-semibold tracking-tight text-primary md:text-3xl">{result.value}</p>
                <h3 className="mt-3 text-base font-semibold">{result.label}</h3>
                <p className="mt-2 text-sm leading-relaxed text-muted-foreground">{result.detail}</p>
              </article>
            ))}
          </div>
        </Section>

        <Section
          id="work"
          index="03"
          title="Evidence"
          lead="Systems I designed, owned or rebuilt — described at the architecture level rather than as a list of technologies."
        >
          <div className="grid gap-4 md:grid-cols-2">
            {projects.map((p) => (
              <article
                key={p.slug}
                className="panel group flex flex-col p-6 transition-colors hover:border-primary/60"
              >
                <div className="flex items-center justify-between gap-4">
                  <span className="font-mono text-[11px] uppercase tracking-widest text-accent">
                    {p.kind}
                  </span>
                  <span className="font-mono text-[11px] text-muted-foreground">{p.period}</span>
                </div>
                <h3 className="mt-4 text-lg font-semibold leading-snug tracking-tight">{p.title}</h3>
                <p className="mt-3 flex-1 text-sm leading-relaxed text-muted-foreground">{p.summary}</p>
                <div className="mt-5 flex flex-wrap gap-1.5">
                  {p.stack.map((s) => (
                    <Tag key={s}>{s}</Tag>
                  ))}
                </div>
              </article>
            ))}
          </div>
        </Section>

        <Section
          id="consulting"
          index="04"
          title="Consulting"
          lead="A focused service layer for teams that need help understanding an expensive, unreliable or difficult-to-scale backend system."
        >
          <div className="grid gap-4 md:grid-cols-3">
            {serviceOffer.map((service) => (
              <article key={service.title} className="panel flex flex-col p-6">
                <h3 className="text-lg font-semibold tracking-tight">{service.title}</h3>
                <p className="mt-3 flex-1 text-sm leading-relaxed text-muted-foreground">{service.summary}</p>
                <p className="mt-5 border-t border-border pt-4 text-xs leading-relaxed text-muted-foreground">
                  {service.fit}
                </p>
              </article>
            ))}
          </div>
          <div className="mt-6 panel flex flex-col gap-5 p-6 md:flex-row md:items-center md:justify-between">
            <div>
              <p className="font-mono text-xs uppercase tracking-widest text-primary">Start with the problem</p>
              <h3 className="mt-2 text-xl font-semibold tracking-tight">Bring the architecture, bottleneck or infrastructure bill.</h3>
              <p className="mt-2 max-w-2xl text-sm text-muted-foreground">
                Send the context you already have. I will use it to decide whether a focused review is useful before proposing any larger work.
              </p>
            </div>
            <a
              href={`mailto:${profile.email}?subject=Consulting%20request`}
              className="shrink-0 rounded-md bg-primary px-5 py-2.5 text-center font-mono text-sm font-medium text-primary-foreground transition-opacity hover:opacity-90"
            >
              Start a conversation →
            </a>
          </div>
        </Section>

        <Section id="experience" index="05" title="Experience">
          <ol className="space-y-10">
            {roles.map((r) => (
              <li
                key={r.title + r.period}
                className="grid gap-4 border-l border-border pl-6 md:grid-cols-[200px_1fr] md:gap-8"
              >
                <div>
                  <p className="font-mono text-xs text-primary">{r.period}</p>
                  <p className="mt-2 text-sm text-muted-foreground">{r.company}</p>
                </div>
                <div>
                  <h3 className="text-lg font-semibold tracking-tight">{r.title}</h3>
                  <p className="mt-2 text-sm text-muted-foreground">{r.summary}</p>
                  <ul className="mt-4 space-y-2">
                    {r.highlights.map((h) => (
                      <li key={h} className="flex gap-3 text-sm leading-relaxed">
                        <span className="mt-2 h-1 w-1 shrink-0 rounded-full bg-primary" aria-hidden="true" />
                        <span className="text-muted-foreground">{h}</span>
                      </li>
                    ))}
                  </ul>
                  <div className="mt-4 flex flex-wrap gap-1.5">
                    {r.stack.map((s) => (
                      <Tag key={s}>{s}</Tag>
                    ))}
                  </div>
                </div>
              </li>
            ))}
          </ol>
        </Section>

        <Section id="skills" index="06" title="Toolkit" lead="The current stack is the result of solving the problems above, not the product itself.">
          <div className="grid gap-4 md:grid-cols-3">
            {skillGroups.map((g) => (
              <div key={g.name} className="panel p-5">
                <h3 className="rule-label">{g.name}</h3>
                <div className="mt-4 flex flex-wrap gap-1.5">
                  {g.items.map((i) => (
                    <Tag key={i}>{i}</Tag>
                  ))}
                </div>
              </div>
            ))}
          </div>
          <div className="panel mt-4 p-5">
            <h3 className="rule-label">Education</h3>
            {education.map((e) => (
              <div key={e.institution} className="mt-4">
                <p className="text-sm font-medium">{e.qualification}</p>
                <p className="text-sm text-muted-foreground">{e.institution} · {e.year} · {e.detail}</p>
              </div>
            ))}
          </div>
        </Section>

        <Section id="writing" index="07" title="Writing" lead="Notes from the work: systems, tradeoffs, failures and what changed afterward.">
          <ul className="divide-y divide-border overflow-hidden rounded-lg border border-border">
            {writing.map((w) => (
              <li key={w.slug}>
                <a
                  href={`${profile.blog}/writing/${w.slug}`}
                  target="_blank"
                  rel="noreferrer"
                  className="flex items-center justify-between gap-4 bg-surface px-5 py-4 transition-colors hover:bg-surface-raised"
                >
                  <span className="text-sm font-medium">{w.title}</span>
                  <span className="font-mono text-xs text-muted-foreground">read →</span>
                </a>
              </li>
            ))}
          </ul>
        </Section>

        <Section
          id="contact"
          index="08"
          title="Contact"
          lead="For backend, platform, infrastructure and focused technical consulting conversations."
        >
          <div className="grid gap-4 md:grid-cols-[1fr_auto] md:items-center">
            <div className="panel p-6">
              <p className="font-mono text-xs uppercase tracking-widest text-primary">Office hours</p>
              <h3 className="mt-2 text-xl font-semibold">Monday–Friday · 10:30–19:30 IST</h3>
              <p className="mt-2 max-w-2xl text-sm leading-relaxed text-muted-foreground">
                I keep consulting conversations within this window alongside my regular work schedule. Email is the best first step; I will reply during office hours.
              </p>
            </div>
            <a
              href={`mailto:${profile.email}?subject=Consulting%20request`}
              className="rounded-md bg-primary px-6 py-3 text-center font-mono text-sm font-medium text-primary-foreground transition-opacity hover:opacity-90"
            >
              Email me →
            </a>
          </div>
          <div className="mt-5 flex flex-wrap gap-3">
            <a
              href={profile.linkedin}
              target="_blank"
              rel="noreferrer"
              className="rounded-md border border-border px-5 py-2.5 font-mono text-sm transition-colors hover:border-primary hover:text-primary"
            >
              LinkedIn
            </a>
            <a
              href={profile.github}
              target="_blank"
              rel="noreferrer"
              className="rounded-md border border-border px-5 py-2.5 font-mono text-sm transition-colors hover:border-primary hover:text-primary"
            >
              GitHub
            </a>
          </div>
        </Section>
      </main>

      <footer className="border-t border-border py-8">
        <div className="mx-auto flex w-full max-w-5xl flex-wrap items-center justify-between gap-3 px-6">
          <p className="font-mono text-xs text-muted-foreground">
            © {new Date().getFullYear()} {profile.name}
          </p>
          <div className="flex items-center gap-4">
            <a
              href={`mailto:${profile.email}`}
              className="font-mono text-xs text-muted-foreground transition-colors hover:text-primary"
            >
              {profile.email}
            </a>
            <a
              href={profile.blog}
              target="_blank"
              rel="noreferrer"
              className="font-mono text-xs text-muted-foreground transition-colors hover:text-primary"
            >
              Blog
            </a>
          </div>
        </div>
      </footer>
    </div>
  );
}
