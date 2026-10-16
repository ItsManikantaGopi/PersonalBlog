export const profile = {
  name: "Manikanta Gopi",
  role: "Senior Backend & Platform Engineer",
  tagline: "I build backend systems that stay reliable as they scale.",
  location: "Hyderabad, India",
  description:
    "Backend, platform and infrastructure engineering focused on cost, performance, reliability and systems that remain understandable in production.",
  intro: [
    "I help startups cut cloud spend, fix backend bottlenecks and ship production-ready products — from a fixed-scope review to an end-to-end build.",
    "My work spans a large Rails platform, Go and NestJS services, real-time systems, media processing, cloud migrations and a GitOps-managed Kubernetes fleet across AWS, GCP and Azure.",
    "I prefer evidence over architecture theatre: find the real constraint, measure it, make the smallest useful change, and verify what moved.",
  ],
  github: "https://github.com/ItsManikantaGopi",
  linkedin: "https://www.linkedin.com/in/gopimanikanta/",
  email: "gopimanikanta50@gmail.com",
  site: "https://manikantagopi.com",
  booking: "https://topmate.io/gopi_manikanta",
  medium: "https://medium.com/@gopimanikanta",
};

export const stats = [
  { value: "~5 yrs", label: "backend engineering", detail: "Dec 2021 → present" },
  { value: "24", label: "services on the fleet", detail: "GitOps-managed on AWS EKS" },
  { value: "3", label: "clouds worked across", detail: "AWS primary, GCP and Azure" },
  { value: "1", label: "zero-downtime migration", detail: "Azure AKS → AWS EKS, live cutover" },
];

export const results = [
  {
    value: "~$18k → ~$1.8k/mo",
    label: "video processing infrastructure",
    detail: "Moved the workload from Lambda + FFmpeg to in-house Kubernetes workers.",
  },
  {
    value: "~$500/mo",
    label: "database savings",
    detail: "Identified resource-intensive queries and changed the surrounding systems.",
  },
  {
    value: "~$400/mo",
    label: "Kubernetes capacity savings",
    detail: "Used Karpenter with Spot + On-Demand capacity for resource-intensive workloads.",
  },
  {
    value: "~$800 saved",
    label: "S3 storage, first month",
    detail: "Added expiry for ephemeral media and prevented storage from growing unchecked.",
  },
];

export const serviceOffer = [
  {
    title: "Cloud & infrastructure cost review",
    summary:
      "Find the workloads, storage, database usage and capacity decisions driving an unexpectedly high AWS, GCP or Azure bill — then fix the ones that matter.",
    fit: "For startups whose cloud spend is growing faster than traffic or revenue.",
    deliverable: "Written findings, a ranked savings plan with estimates, and hands-on fixes if you want them.",
  },
  {
    title: "Backend architecture & bottleneck review",
    summary:
      "Trace a slow or unreliable workflow through services, queues, storage and infrastructure to identify the constraint that actually matters.",
    fit: "Before a major build, migration or scaling decision — or when dashboards show symptoms but not the root cause.",
    deliverable: "Architecture notes, the root cause with evidence, and a prioritised remediation plan.",
  },
  {
    title: "Kubernetes, AWS & migrations",
    summary:
      "Review or set up deployment, autoscaling (KEDA, Karpenter), GitOps, observability and cloud migrations without a maintenance window.",
    fit: "For teams that grew quickly and want a reliable, understandable platform without a rewrite.",
    deliverable: "A working, documented setup in your repositories — Terraform, Helm and runbooks your team can own.",
  },
  {
    title: "MVP & product builds",
    summary:
      "Design and ship a production-ready product end to end: mobile or web client, API, data model, background jobs, infrastructure and launch.",
    fit: "For founders who need a working product — not a prototype that has to be rebuilt after the first customers arrive.",
    deliverable: "A deployed product, source code you own, and a handover so your next engineer can take it forward.",
  },
  {
    title: "WhatsApp API integrations",
    summary:
      "Connect WhatsApp Business messaging to your product — notifications, conversational flows, queues and delivery tracking — built on the same stack as SoloSync.",
    fit: "For businesses that want reliable WhatsApp messaging without building the plumbing themselves.",
    deliverable: "A production integration, or onboarding onto SoloSync's developer platform.",
  },
];

export const engagementSteps = [
  {
    step: "01",
    title: "Free 15-minute intro call",
    detail: "Book a slot on Topmate and describe the problem. I tell you honestly whether I can help and what a first step would look like.",
  },
  {
    step: "02",
    title: "Fixed-scope proposal",
    detail: "A written scope, timeline and fixed price before any work starts — no open-ended hourly billing surprises.",
  },
  {
    step: "03",
    title: "Delivery & handover",
    detail: "Regular written updates, work in your repositories, and documentation so your team owns the result.",
  },
];

export type Product = {
  name: string;
  company: string;
  summary: string;
  status: string;
  href: string;
  stack: string[];
};

export const products: Product[] = [
  {
    name: "SoloSync",
    company: "SoloSyncTech",
    summary:
      "A developer platform for the WhatsApp messaging APIs — connection management, wallet, API keys and production messaging from one workspace.",
    status: "Founder · early access",
    href: "https://app.solosync.live",
    stack: ["APIs", "Queues", "Background jobs", "WhatsApp Business"],
  },
  {
    name: "Nivaro Recruiter",
    company: "SoloSyncTech",
    summary:
      "An AI hiring-operations workspace: resume intelligence, job-specific matching, technical assessments and one structured candidate pipeline.",
    status: "Founder · MVP",
    href: "https://screen.solosync.live",
    stack: ["AI screening", "Multi-tenant workspaces", "Assessments"],
  },
];

export type Problem = {
  title: string;
  summary: string;
  evidence: string;
  href?: string;
};

export const problems: Problem[] = [
  {
    title: "Infrastructure costs are too high",
    summary: "Find the expensive workload, storage lifecycle or capacity decision instead of cutting infrastructure blindly.",
    evidence: "Reduced video-processing infrastructure from roughly $18k/month to ~$1.8k/month and delivered additional DB, S3 and Kubernetes savings.",
    href: "#results",
  },
  {
    title: "Scaling backend workloads",
    summary: "Move capacity decisions from guesswork to the signal that actually represents work in the system.",
    evidence: "KEDA-scaled media workers driven by queue depth, plus seasonal capacity planning for festival-day peaks.",
    href: "#work",
  },
  {
    title: "Distributed systems",
    summary: "Design boundaries, fan-out paths and asynchronous workflows without hiding the operational cost.",
    evidence: "Real-time messaging with Socket.IO and Redis pub/sub, plus separate Go and NestJS services around the core platform.",
    href: "#work",
  },
  {
    title: "Infrastructure and migrations",
    summary: "Change the underlying platform while keeping the product moving and the blast radius controlled.",
    evidence: "Production migration from Azure AKS to AWS EKS with Terraform, service-by-service cutover, DNS/CDN moves and deliberate decommissioning.",
    href: "#work",
  },
  {
    title: "Performance and observability",
    summary: "Measure the slow path, make it legible, and verify that the fix improved the right thing.",
    evidence: "Rails and Sidekiq workload tuning, OpenSearch-backed systems, CI timing splits, and New Relic / Prometheus / Grafana / Loki instrumentation.",
    href: "#work",
  },
  {
    title: "Applied ML infrastructure",
    summary: "Take an ML capability from an external black box to an operationally owned service when the economics or control justify it.",
    evidence: "Background removal moved from a hosted vision API to a self-hosted ONNX GPU service in the Kubernetes cluster.",
    href: "#work",
  },
];

export type Project = {
  slug: string;
  title: string;
  summary: string;
  period: string;
  stack: string[];
  kind: "Platform" | "Infrastructure" | "Backend" | "ML" | "Open source";
  href?: string;
};

export const projects: Project[] = [
  {
    slug: "praja-platform",
    title: "The Rails monolith at the centre of a social platform",
    summary:
      "185 models, 211 background workers and ~28 Sidekiq queues serving a regional social network. Four years of feature work, performance work, and the discipline of keeping a large monolith habitable.",
    period: "2022 – present",
    stack: ["Ruby on Rails", "MySQL", "Redis", "Sidekiq", "OpenSearch"],
    kind: "Platform",
  },
  {
    slug: "gitops-fleet",
    title: "Running a 24-service fleet from a Git repository",
    summary:
      "Helm charts, per-environment values and automated image bumps describing every service in production — most changes deliberately small, so the tree stays reviewable.",
    period: "2024 – present",
    stack: ["Kubernetes", "Helm", "Flux", "ArgoCD", "KEDA", "Karpenter"],
    kind: "Infrastructure",
  },
  {
    slug: "realtime-messaging",
    title: "A real-time messaging service, and the parts that were hard",
    summary:
      "NestJS and Socket.IO with Redis pub/sub for cross-instance fan-out and MongoDB for persistence. Three years of ownership — including adding a message broker and later removing it.",
    period: "2023 – 2026",
    stack: ["NestJS", "Socket.IO", "Redis", "MongoDB", "BullMQ"],
    kind: "Backend",
  },
  {
    slug: "multi-cloud-migration",
    title: "Moving production from Azure to AWS, service by service",
    summary:
      "A live migration from AKS to EKS — Terraform for the new estate, one service at a time, DNS and CDN last, then a deliberate decommission. No maintenance window.",
    period: "2024 – 2025",
    stack: ["Terraform", "AWS EKS", "Azure AKS", "CloudFront", "Route 53"],
    kind: "Infrastructure",
  },
  {
    slug: "poster-video-pipeline",
    title: "The media pipeline behind the paid tier",
    summary:
      "Compositing user photography onto templated poster and video designs at festival-day volumes. Moved from Lambda + FFmpeg to KEDA-scaled in-cluster workers driven by queue depth.",
    period: "2024 – present",
    stack: ["NestJS", "FFmpeg", "Puppeteer", "Redis", "KEDA", "S3"],
    kind: "Backend",
  },
  {
    slug: "background-removal-ml",
    title: "Replacing a vendor vision API with a self-hosted GPU service",
    summary:
      "Background removal moved from per-call cloud API to an ONNX model on GPU nodes in-cluster, then a face-detector swap validated against 200 real production images before shipping.",
    period: "2025 – 2026",
    stack: ["Python", "ONNX Runtime", "OpenCV", "BiRefNet", "SCRFD"],
    kind: "ML",
  },
  {
    slug: "garuda-notifications",
    title: "A Go notification service for fan-out at population scale",
    summary:
      "Targeting users by district, state, party and circle, then dispatching push through FCM without touching the main API's request path.",
    period: "2024 – present",
    stack: ["Go", "Gin", "GORM", "Asynq", "Redis", "FCM"],
    kind: "Backend",
  },
  {
    slug: "ci-cd-and-observability",
    title: "The release path, and knowing when it broke",
    summary:
      "CircleCI with timing-based test splitting, build capacity on our own cluster, plus the instrumentation and backup drills that make production legible.",
    period: "2024 – present",
    stack: ["CircleCI", "New Relic", "Prometheus", "Grafana", "Loki", "Velero"],
    kind: "Infrastructure",
  },
  {
    slug: "seeker",
    title: "Seeker: a search engine built from first principles",
    summary:
      "An inverted index, BM25, Levenshtein automata, FSTs, BKD trees, a byte-level segment format and a breakable cluster — ~20,000 lines of TypeScript with a 43-chapter book.",
    period: "2026",
    stack: ["TypeScript", "Next.js", "React"],
    kind: "Open source",
  },
  {
    slug: "rails2x",
    title: "rails2x: an AST-based Rails → Go migration engine",
    summary:
      "Parses a Rails codebase with tree-sitter and generates Goravel Go code for models, CRUD controllers, Sidekiq workers, Pundit policies and RSpec scaffolds — automating the bulk of the structural work, with a strict mode that refuses partial output.",
    period: "2026",
    stack: ["Go", "tree-sitter", "Goravel", "GORM"],
    kind: "Open source",
    href: "https://github.com/ItsManikantaGopi/rails2x",
  },
  {
    slug: "sidekiq-assured-jobs",
    title: "sidekiq-assured-jobs: not losing the job when the worker dies",
    summary:
      "A Ruby gem that tracks in-flight Sidekiq jobs and re-enqueues whatever a killed worker was holding, because Kubernetes evicts pods and Sidekiq does not remember what it lost.",
    period: "2025",
    stack: ["Ruby", "Sidekiq", "Redis", "RSpec"],
    kind: "Open source",
    href: "https://github.com/praja/sidekiq-assured-jobs",
  },
];

export const roles = [
  {
    company: "Circleapp Online Services (Praja)",
    title: "Senior Software Engineer",
    period: "Apr 2025 – Present",
    summary:
      "Platform and infrastructure ownership alongside product work: the Kubernetes fleet, the media generation pipeline, and the release path everything ships through.",
    highlights: [
      "Own the GitOps repository describing ~24 services on the production AWS cluster — Helm charts, per-environment values, automated image bumps on merge.",
      "Reduced video-processing infrastructure from roughly $18k/month to ~$1.8k/month by moving Lambda + FFmpeg workloads to in-house Kubernetes workers.",
      "Optimized database workloads and storage lifecycle, contributing roughly $500/month in DB savings and ~$800 saved in the first month from S3 expiry policies.",
      "Enabled Karpenter with Spot + On-Demand capacity for resource-intensive workloads, reducing costs by roughly $400/month.",
      "Migrated queueing infrastructure from Redis to Dragonfly without downtime.",
      "Took background removal from a hosted vendor API to a self-hosted ONNX GPU service in-cluster.",
    ],
    stack: ["Kubernetes", "Helm", "Terraform", "AWS", "KEDA", "Karpenter", "CircleCI", "Rails", "NestJS", "Go"],
  },
  {
    company: "Circleapp Online Services (Praja)",
    title: "Software Engineer",
    period: "May 2022 – Mar 2025",
    summary:
      "Backend feature work on the Rails monolith and the services around it, growing into the multi-cloud migration and the platform work that came with it.",
    highlights: [
      "Built and ran the real-time messaging service — NestJS, Socket.IO, Redis pub/sub fan-out, MongoDB persistence, BullMQ for deferred work.",
      "Led the migration of production from Azure AKS to AWS EKS: Terraform estate, service-by-service cutover, DNS and CDN moves, then decommission.",
      "Implemented the subscription lifecycle in the monolith — charge scheduling, grace periods, refunds, idempotent handling of duplicate gateway callbacks.",
      "Wrote the poster and video generation pipeline the paid tier is built on.",
      "Published sidekiq-assured-jobs.",
    ],
    stack: ["Ruby on Rails", "NestJS", "Socket.IO", "Redis", "MySQL", "MongoDB", "Sidekiq", "Terraform", "Flutter"],
  },
  {
    company: "Circleapp Online Services (Praja)",
    title: "Software Engineer Intern",
    period: "Dec 2021 – Apr 2022",
    summary: "Started on the Flutter client, then moved toward the API that fed it.",
    highlights: [
      "Shipped chat features in the Flutter app — conversation types, message deletion, link and post previews, member lists.",
      "Moved into the Rails API for the endpoints those features needed.",
    ],
    stack: ["Flutter", "Dart", "Ruby on Rails"],
  },
  {
    company: "Continual Engine",
    title: "Machine Learning Intern",
    period: "2021",
    summary: "Applied-ML internship on image understanding for accessibility tooling.",
    highlights: [
      "Built image-to-text models in PyTorch, including autoencoders for feature extraction.",
      "Ran the training loop and the evaluation that decided whether a change was an improvement.",
    ],
    stack: ["Python", "PyTorch", "NumPy"],
  },
];

export const skillGroups = [
  {
    name: "Languages",
    items: ["Ruby", "TypeScript", "Go", "Python", "Dart", "Bash", "SQL"],
  },
  {
    name: "Backend",
    items: ["Ruby on Rails", "NestJS", "Sidekiq", "BullMQ", "Socket.IO", "Asynq", "Gin + GORM", "REST API design"],
  },
  {
    name: "Data & storage",
    items: ["MySQL", "Redis", "MongoDB", "OpenSearch", "PostgreSQL", "S3"],
  },
  {
    name: "Infrastructure",
    items: ["Kubernetes", "Helm", "Terraform", "Docker", "KEDA", "Karpenter", "Flux / ArgoCD", "APISIX"],
  },
  {
    name: "Cloud",
    items: ["AWS", "GCP", "Azure"],
  },
  {
    name: "Delivery & observability",
    items: ["CircleCI", "GitHub Actions", "New Relic", "Prometheus + Grafana", "Loki", "Velero"],
  },
];

export const education = [
  {
    institution: "Rajiv Gandhi University of Knowledge Technologies",
    qualification: "B.Tech, Computer Science",
    year: "2022",
    detail: "GPA 9.3 / 10",
  },
];
