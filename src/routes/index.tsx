import { createFileRoute } from "@tanstack/react-router";
import {
  profile,
  stats,
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
      { title: "Manikanta Gopi — Backend & Platform Engineering" },
      {
        name: "description",
        content:
          "Manikanta Gopi — backend, platform and infrastructure engineering, architecture reviews and system design mentoring.",
      },
      { property: "og:title", content: "Manikanta Gopi — Backend & Platform Engineering" },
      {
        property: "og:description",
        content:
          "Production backend systems, platform engineering, architecture thinking and focused technical consulting.",
      },
      { property: "og:type", content: "profile" },
      { name: "twitter:card", content: "summary_large_image" },
    ],
  }),
  component: Portfolio,
});

const nav = [
  { href: "#problems", label: "Problems" },
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
            href="#consulting"
            className="rounded-md bg-primary px-3 py-1.5 font-mono text-xs font-medium text-primary-foreground transition-opacity hover:opacity-90"
          >
            Work with me
          </a>
        </div>
      </header>

      <main id="top">
        <section className="hero-glow">
          <div className="mx-auto w-full max-w-5xl px-6 pb-20 pt-20 md:pb-28 md:pt-28">
            <span className="rule-label">
              {profile.role} · {profile.location}
            </span>
            <h1 className="mt-5 max-w-4xl text-4xl font-semibold leading-[1.04] tracking-tight md:text-6xl">
              {profile.name}
              <span className="block text-primary">{profile.tagline}</span>
            </h1>
            <div className="mt-8 max-w-2xl space-y-4 text-base leading-relaxed text-muted-foreground md:text-lg">
              {profile.intro.map((p) => (
                <p key={p.slice(0, 24)}>{p}</p>
              ))}
            </div>
            <div className="mt-10 flex flex-wrap gap-3">
              <a
                href="#consulting"
                className="rounded-md bg-primary px-5 py-2.5 font-mono text-sm font-medium text-primary-foreground transition-opacity hover:opacity-90"
              >
                Discuss a problem
              </a>
              <a
                href="#work"
                className="rounded-md border border-border px-5 py-2.5 font-mono text-sm transition-colors hover:border-primary hover:text-primary"
              >
                See the evidence
              </a>
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
                  <p className="text-xs font-mono uppercase tracking-widest text-primary">Proof</p>
                  <p className="mt-2 text-sm leading-relaxed">{problem.evidence}</p>
                </div>
              </article>
            ))}
          </div>
        </Section>

        <Section
          id="work"
          index="02"
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
          index="03"
          title="Consulting"
          lead="A small, practical service layer around the areas where my production experience is most useful."
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
              <h3 className="mt-2 text-xl font-semibold tracking-tight">Bring the architecture, bottleneck or design question.</h3>
              <p className="mt-2 max-w-2xl text-sm text-muted-foreground">
                Send context before the call; the goal is a focused conversation, not a generic consulting deck.
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

        <Section id="experience" index="04" title="Experience">
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
                        <span className="mt-2 h-1 w-1 shrink-0 rounded-full bg-primary" />
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

        <Section id="skills" index="05" title="Toolkit" lead="The current stack is the result of solving the problems above, not the product itself.">
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

        <Section id="writing" index="06" title="Writing" lead="Notes from the work: systems, tradeoffs, failures and what changed afterward.">
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
          index="07"
          title="Contact"
          lead="For backend, platform, infrastructure and focused technical consulting conversations."
        >
          <div className="flex flex-wrap gap-3">
            <a
              href={`mailto:${profile.email}`}
              className="rounded-md bg-primary px-5 py-2.5 font-mono text-sm font-medium text-primary-foreground transition-opacity hover:opacity-90"
            >
              Email me
            </a>
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
          <p className="font-mono text-xs text-muted-foreground">© {new Date().getFullYear()} {profile.name}</p>
          <a
            href={profile.blog}
            target="_blank"
            rel="noreferrer"
            className="font-mono text-xs text-muted-foreground transition-colors hover:text-primary"
          >
            Blog & case studies →
          </a>
        </div>
      </footer>
    </div>
  );
}
