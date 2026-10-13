import { createFileRoute } from "@tanstack/react-router";
import {
  profile,
  stats,
  results,
  projects,
  roles,
  skillGroups,
  education,
  serviceOffer,
  problems,
  products,
  engagementSteps,
} from "@/data/portfolio";

const siteUrl = profile.site;
const pageTitle = "Manikanta Gopi — Senior Backend & Platform Engineer";
const pageDescription =
  "Backend, cloud and Kubernetes engineer for startups: infrastructure cost reviews, architecture reviews, AWS migrations, MVP builds and WhatsApp API integrations.";

const jsonLd = {
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "Person",
      "@id": `${siteUrl}/#person`,
      name: profile.name,
      jobTitle: profile.role,
      url: siteUrl,
      email: `mailto:${profile.email}`,
      address: { "@type": "PostalAddress", addressLocality: "Hyderabad", addressCountry: "IN" },
      sameAs: [profile.github, profile.linkedin, profile.medium, profile.booking],
      knowsAbout: ["Backend engineering", "Kubernetes", "AWS", "Cloud cost optimization", "Distributed systems"],
    },
    {
      "@type": "ProfessionalService",
      name: `${profile.name} — Backend & Platform Engineering`,
      url: siteUrl,
      provider: { "@id": `${siteUrl}/#person` },
      areaServed: "Worldwide",
      serviceType: serviceOffer.map((s) => s.title),
    },
  ],
};

export const Route = createFileRoute("/")({
  head: () => ({
    meta: [
      { title: pageTitle },
      { name: "description", content: pageDescription },
      { property: "og:title", content: pageTitle },
      { property: "og:description", content: pageDescription },
      { property: "og:type", content: "profile" },
      { property: "og:url", content: `${siteUrl}/` },
      { property: "og:image", content: `${siteUrl}/og-image.png` },
      { property: "og:image:width", content: "1200" },
      { property: "og:image:height", content: "630" },
      { name: "twitter:card", content: "summary_large_image" },
      { name: "twitter:title", content: pageTitle },
      { name: "twitter:description", content: pageDescription },
      { name: "twitter:image", content: `${siteUrl}/og-image.png` },
    ],
    links: [{ rel: "canonical", href: `${siteUrl}/` }],
    scripts: [{ type: "application/ld+json", children: JSON.stringify(jsonLd) }],
  }),
  component: Portfolio,
});

const nav = [
  { href: "#problems", label: "Problems" },
  { href: "#results", label: "Results" },
  { href: "#work", label: "Work" },
  { href: "#products", label: "Products" },
  { href: "#consulting", label: "Services" },
  { href: "#experience", label: "Experience" },
  { href: "#contact", label: "Contact" },
];

const consultingHref = `mailto:${profile.email}?subject=${encodeURIComponent(
  "Consulting request",
)}&body=${encodeURIComponent(
  "Hi Gopi,\n\nI'd like to discuss a project.\n\nCompany / product:\nWhat's expensive, slow or blocked:\nTimeline:\n\n",
)}`;

const bookingProps = { href: profile.booking, target: "_blank", rel: "noreferrer" } as const;

const primaryCtaClass =
  "inline-flex min-h-11 items-center justify-center whitespace-nowrap rounded-md bg-primary px-5 py-2.5 font-mono text-sm font-medium text-primary-foreground shadow-sm transition-all hover:-translate-y-0.5 hover:opacity-90 hover:shadow-md focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary focus-visible:ring-offset-2 focus-visible:ring-offset-background";

const secondaryCtaClass =
  "inline-flex min-h-11 items-center justify-center whitespace-nowrap rounded-md border border-border bg-background/50 px-5 py-2.5 font-mono text-sm font-medium transition-all hover:-translate-y-0.5 hover:border-primary hover:bg-surface hover:text-primary focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary focus-visible:ring-offset-2 focus-visible:ring-offset-background";

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
    <section id={id} className="scroll-mt-20 border-t border-border py-16 md:py-24">
      <div className="mx-auto w-full max-w-5xl px-6">
        <div className="mb-9 flex flex-col gap-3 md:mb-12">
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
      <header className="sticky top-0 z-50 border-b border-border bg-background/90 backdrop-blur">
        <div className="mx-auto flex w-full max-w-5xl items-center justify-between gap-4 px-6 py-4">
          <a href="#top" className="shrink-0 font-mono text-sm font-medium tracking-tight">
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
            <a
              href="/resume.pdf"
              target="_blank"
              rel="noreferrer"
              className="font-mono text-[11px] uppercase tracking-widest text-muted-foreground transition-colors hover:text-foreground"
            >
              Resume
            </a>
          </nav>
          <a {...bookingProps} className={`${primaryCtaClass} min-h-9 px-3 py-1.5 text-xs`}>
            Book a free call
          </a>
        </div>
      </header>

      <main id="top">
        <section className="hero-glow">
          <div className="mx-auto w-full max-w-5xl px-6 pb-20 pt-14 md:pb-24 md:pt-20">
            <div className="max-w-4xl">
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
              <div className="mt-9 flex flex-wrap gap-3">
                <a {...bookingProps} className={primaryCtaClass}>
                  Book a free intro call <span aria-hidden="true">→</span>
                </a>
                <a href="#results" className={secondaryCtaClass}>
                  See the results <span className="ml-1" aria-hidden="true">↓</span>
                </a>
              </div>
            </div>

            <dl className="mt-14 grid grid-cols-2 gap-px overflow-hidden rounded-lg border border-border bg-border md:grid-cols-4">
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
              <article key={problem.title} className="panel p-6 transition-colors hover:border-primary/50">
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
              <article key={result.label} className="panel p-6 transition-colors hover:border-primary/50">
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
                  <span className="font-mono text-[11px] uppercase tracking-widest text-accent">{p.kind}</span>
                  <span className="font-mono text-[11px] text-muted-foreground">{p.period}</span>
                </div>
                <h3 className="mt-4 text-lg font-semibold leading-snug tracking-tight">{p.title}</h3>
                <p className="mt-3 flex-1 text-sm leading-relaxed text-muted-foreground">{p.summary}</p>
                {p.href ? (
                  <a
                    href={p.href}
                    target="_blank"
                    rel="noreferrer"
                    className="mt-4 font-mono text-xs text-primary hover:underline"
                  >
                    View source ↗
                  </a>
                ) : null}
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
          id="products"
          index="04"
          title="Products I've built"
          lead="Alongside client and employer work, I design, build and run my own products end to end — client, API, data, infrastructure and launch."
        >
          <div className="grid gap-4 md:grid-cols-2">
            {products.map((product) => (
              <a
                key={product.name}
                href={product.href}
                target="_blank"
                rel="noreferrer"
                className="panel group flex flex-col p-6 transition-colors hover:border-primary/60"
              >
                <div className="flex items-center justify-between gap-4">
                  <span className="font-mono text-[11px] uppercase tracking-widest text-accent">{product.company}</span>
                  <span className="font-mono text-[11px] text-muted-foreground">{product.status}</span>
                </div>
                <h3 className="mt-4 text-lg font-semibold tracking-tight group-hover:text-primary">
                  {product.name} <span aria-hidden="true">↗</span>
                </h3>
                <p className="mt-3 flex-1 text-sm leading-relaxed text-muted-foreground">{product.summary}</p>
                <div className="mt-5 flex flex-wrap gap-1.5">
                  {product.stack.map((s) => (
                    <Tag key={s}>{s}</Tag>
                  ))}
                </div>
              </a>
            ))}
          </div>
        </Section>

        <Section
          id="consulting"
          index="05"
          title="Services"
          lead="Fixed-scope engagements for startups and product teams — from a focused review of an expensive or unreliable system to a complete product build."
        >
          <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
            {serviceOffer.map((service) => (
              <article key={service.title} className="panel flex flex-col p-6 transition-colors hover:border-primary/50">
                <h3 className="text-lg font-semibold tracking-tight">{service.title}</h3>
                <p className="mt-3 flex-1 text-sm leading-relaxed text-muted-foreground">{service.summary}</p>
                <p className="mt-5 border-t border-border pt-4 text-xs leading-relaxed text-muted-foreground">{service.fit}</p>
                <p className="mt-3 text-xs leading-relaxed">
                  <span className="font-mono uppercase tracking-widest text-primary">You get · </span>
                  {service.deliverable}
                </p>
              </article>
            ))}
          </div>

          <div className="mt-10">
            <p className="rule-label">How an engagement works</p>
            <ol className="mt-5 grid gap-4 md:grid-cols-3">
              {engagementSteps.map((s) => (
                <li key={s.step} className="panel p-6">
                  <p className="font-mono text-2xl font-semibold text-primary">{s.step}</p>
                  <h3 className="mt-3 text-base font-semibold">{s.title}</h3>
                  <p className="mt-2 text-sm leading-relaxed text-muted-foreground">{s.detail}</p>
                </li>
              ))}
            </ol>
          </div>

          <div className="mt-6 panel flex flex-col gap-5 p-6 md:flex-row md:items-center md:justify-between">
            <div>
              <p className="font-mono text-xs uppercase tracking-widest text-primary">Start with the problem</p>
              <h3 className="mt-2 text-xl font-semibold tracking-tight">Bring the architecture, the bottleneck, the cloud bill or the product idea.</h3>
              <p className="mt-2 max-w-2xl text-sm text-muted-foreground">
                Send the context you already have. I reply within one working day and tell you whether a focused engagement makes sense before proposing any larger work.
              </p>
            </div>
            <div className="flex shrink-0 flex-col gap-2 sm:flex-row">
              <a {...bookingProps} className={primaryCtaClass}>
                Book a free call <span aria-hidden="true">→</span>
              </a>
              <a href={consultingHref} className={secondaryCtaClass}>
                Email instead
              </a>
            </div>
          </div>
        </Section>

        <Section id="experience" index="06" title="Experience">
          <ol className="space-y-10">
            {roles.map((r) => (
              <li key={r.title + r.period} className="grid gap-4 border-l border-border pl-6 md:grid-cols-[200px_1fr] md:gap-8">
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

        <Section id="skills" index="07" title="Toolkit" lead="The current stack is the result of solving the problems above, not the product itself.">
          <div className="grid gap-4 md:grid-cols-3">
            {skillGroups.map((g) => (
              <div key={g.name} className="panel p-5 transition-colors hover:border-primary/50">
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

        <Section
          id="contact"
          index="08"
          title="Let's work together"
          lead="For backend, platform, infrastructure and focused technical consulting conversations."
        >
          <div className="grid gap-4 lg:grid-cols-[minmax(0,1.35fr)_minmax(280px,0.65fr)]">
            <div className="panel p-6 md:p-7">
              <div className="flex items-start gap-4">
                <div className="contact-icon" aria-hidden="true">@</div>
                <div>
                  <p className="font-mono text-xs uppercase tracking-widest text-primary">Direct contact</p>
                  <h3 className="mt-2 text-xl font-semibold tracking-tight">Book a call or drop me an email</h3>
                  <p className="mt-2 max-w-xl text-sm leading-relaxed text-muted-foreground">
                    Tell me what is expensive, slow, unreliable or difficult to reason about. A short description is enough to start.
                  </p>
                </div>
              </div>
              <a {...bookingProps} className={`${primaryCtaClass} mt-6 w-full`}>
                Book a free call <span aria-hidden="true">↗</span>
              </a>
              <a href={consultingHref} className={`${secondaryCtaClass} mt-3 w-full`}>
                Email me <span aria-hidden="true">→</span>
              </a>
            </div>

            <div className="panel p-6 md:p-7">
              <p className="font-mono text-xs uppercase tracking-widest text-primary">Good fit</p>
              <h3 className="mt-2 text-xl font-semibold tracking-tight">Bring a real engineering problem.</h3>
              <ul className="mt-5 space-y-3 text-sm text-muted-foreground">
                <li className="flex gap-3"><span className="text-primary" aria-hidden="true">✓</span> Infrastructure cost or capacity</li>
                <li className="flex gap-3"><span className="text-primary" aria-hidden="true">✓</span> Backend bottlenecks and scaling</li>
                <li className="flex gap-3"><span className="text-primary" aria-hidden="true">✓</span> Kubernetes and cloud decisions</li>
                <li className="flex gap-3"><span className="text-primary" aria-hidden="true">✓</span> Architecture and reliability reviews</li>
                <li className="flex gap-3"><span className="text-primary" aria-hidden="true">✓</span> MVPs and WhatsApp API integrations</li>
              </ul>
            </div>
          </div>

          <div className="mt-4 grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
            <a href="/resume.pdf" target="_blank" rel="noreferrer" className={`${secondaryCtaClass} justify-start`}>
              View resume <span className="ml-auto" aria-hidden="true">↗</span>
            </a>
            <a href={profile.linkedin} target="_blank" rel="noreferrer" className={`${secondaryCtaClass} justify-start`}>
              LinkedIn <span className="ml-auto" aria-hidden="true">↗</span>
            </a>
            <a href={profile.github} target="_blank" rel="noreferrer" className={`${secondaryCtaClass} justify-start`}>
              GitHub <span className="ml-auto" aria-hidden="true">↗</span>
            </a>
            <a href={profile.medium} target="_blank" rel="noreferrer" className={`${secondaryCtaClass} justify-start`}>
              Writing on Medium <span className="ml-auto" aria-hidden="true">↗</span>
            </a>
          </div>
        </Section>
      </main>

      <footer className="border-t border-border py-8">
        <div className="mx-auto flex w-full max-w-5xl flex-wrap items-center justify-between gap-4 px-6">
          <div>
            <p className="font-mono text-sm font-medium"><span className="text-primary">~/</span>{profile.name}</p>
            <p className="mt-1 font-mono text-xs text-muted-foreground">Backend systems · Cloud infrastructure · Product builds</p>
          </div>
          <div className="flex flex-wrap items-center gap-4">
            <a href={`mailto:${profile.email}`} className="font-mono text-xs text-muted-foreground transition-colors hover:text-primary">{profile.email}</a>
            <a href="/resume.pdf" target="_blank" rel="noreferrer" className="font-mono text-xs text-muted-foreground transition-colors hover:text-primary">Resume</a>
          </div>
        </div>
        <div className="mx-auto mt-5 w-full max-w-5xl px-6">
          <p className="font-mono text-[11px] text-muted-foreground">© {new Date().getFullYear()} {profile.name}. All rights reserved.</p>
        </div>
      </footer>
    </div>
  );
}
