/**
 * Single source of truth for everything about me that isn't long-form content.
 *
 * Rule for this file: every number here is one I can point at a repository,
 * a dashboard or a merged pull request to justify. If a figure can't be
 * defended in an interview, it doesn't belong here.
 */

export const site = {
  name: 'Manikanta Gopi',
  shortName: 'Manikanta',
  role: 'Software Engineer II',
  tagline: 'Backend, platform and infrastructure engineering.',
  description:
    'Software engineer working on backend systems and the infrastructure they run on — a Rails monolith, Go and NestJS services, and a GitOps-managed Kubernetes fleet across AWS, GCP and Azure.',
  url: 'https://itsmanikantagopi.github.io/PersonalBlog',
  locale: 'en_IN',
  location: 'Hyderabad, India',
} as const

export const social = {
  github: 'https://github.com/ItsManikantaGopi',
  githubUser: 'ItsManikantaGopi',
  linkedin: 'https://www.linkedin.com/in/manikanta-gopi-549163190',
  email: 'manikantagopiw@gmail.com',
} as const

/**
 * The one-paragraph version, for the hero.
 */
export const intro = [
  'I build the parts of a product that have to stay up.',
  "For the last four years that has meant Praja — a regional social platform — where I've worked across a Ruby on Rails monolith, a set of Go and NestJS services around it, and the Kubernetes fleet all of it runs on. Roughly 1,700 merged pull requests, spread fairly evenly between writing features and keeping the platform standing under them.",
  'I like the problems where the answer is a measurement rather than an opinion: which queue is actually the bottleneck, what the p90 really is, whether the new model is better or just different.',
] as const

export type Role = {
  company: string
  title: string
  start: string
  end: string | 'Present'
  summary: string
  highlights: string[]
  stack: string[]
}

export const roles: Role[] = [
  {
    company: 'Circleapp Online Services (Praja)',
    title: 'Software Engineer II',
    start: 'Apr 2025',
    end: 'Present',
    summary:
      'Platform and infrastructure ownership alongside product work: the Kubernetes fleet, the media generation pipeline, and the release path everything ships through.',
    highlights: [
      'Own the GitOps repository that describes ~24 services on the production AWS cluster — Helm charts, per-environment values, and the automation that bumps image tags on merge.',
      'Built the in-cluster video poster pipeline that replaced a Lambda + FFmpeg design, moving generation onto KEDA-scaled workers driven by Redis queue depth.',
      'Moved CI from GitHub Actions to CircleCI with timing-based test splitting across parallel containers, and moved deployments for the API, web and admin apps onto the same path.',
      'Ran the seasonal capacity work — the platform has sharp, predictable traffic peaks on festival days, which get planned scale-ups and post-event scale-downs rather than hope.',
      'Took the background-removal service from a hosted vendor API to a self-hosted ONNX GPU service in-cluster, and validated a face-detector swap against 200 real production images before shipping it.',
    ],
    stack: [
      'Kubernetes',
      'Helm',
      'Terraform',
      'AWS',
      'KEDA',
      'Karpenter',
      'CircleCI',
      'Ruby on Rails',
      'NestJS',
      'Go',
    ],
  },
  {
    company: 'Circleapp Online Services (Praja)',
    title: 'Software Engineer',
    start: 'May 2022',
    end: 'Mar 2025',
    summary:
      'Backend feature work on the Rails monolith and the services around it, growing into the multi-cloud migration and the platform work that came with it.',
    highlights: [
      'Built and ran the real-time messaging service — NestJS, Socket.IO, Redis pub/sub for cross-instance fan-out, MongoDB for persistence, BullMQ for deferred work.',
      'Led the migration of the production workload from Azure AKS to AWS EKS: Terraform for the new estate, service-by-service cutover, DNS and CDN moves, then decommissioning the Azure resources.',
      'Implemented the subscription lifecycle in the Rails monolith — charge scheduling, grace periods, cancellation and downgrade flows, partial refunds, and idempotent handling of duplicate and late payment-gateway callbacks.',
      'Wrote the poster and video generation pipeline that composites user photography onto templated designs — the feature the paid tier is built on.',
      'Published sidekiq-assured-jobs, a gem that tracks in-flight Sidekiq jobs and re-enqueues whatever a killed worker was holding.',
    ],
    stack: [
      'Ruby on Rails',
      'NestJS',
      'Socket.IO',
      'Redis',
      'MySQL',
      'MongoDB',
      'Sidekiq',
      'AWS Lambda',
      'Terraform',
      'Flutter',
    ],
  },
  {
    company: 'Circleapp Online Services (Praja)',
    title: 'Software Engineer Intern',
    start: 'Dec 2021',
    end: 'Apr 2022',
    summary:
      'Started on the Flutter client, then moved toward the API that fed it.',
    highlights: [
      'Shipped chat features in the Flutter app — conversation types, message deletion, link and post previews, member lists.',
      'Moved into the Rails API for the endpoints those features needed.',
    ],
    stack: ['Flutter', 'Dart', 'Ruby on Rails'],
  },
  {
    company: 'Continual Engine',
    title: 'Machine Learning Intern',
    start: '2021',
    end: '2021',
    summary:
      'Applied-ML internship on image understanding for accessibility tooling.',
    highlights: [
      'Built image-to-text models in PyTorch, including autoencoders for feature extraction.',
      'Ran the training loop and the evaluation that decided whether a change was actually an improvement.',
    ],
    stack: ['Python', 'PyTorch', 'NumPy'],
  },
]

export const education = [
  {
    institution: 'Rajiv Gandhi University of Knowledge Technologies',
    qualification: 'B.Tech, Computer Science',
    year: '2022',
    detail: 'GPA 9.3 / 10',
  },
  {
    institution: 'Rajiv Gandhi University of Knowledge Technologies',
    qualification: 'Pre-University Course (MPC)',
    year: '2018',
    detail: 'GPA 8.4 / 10',
  },
]

/**
 * Skills grouped the way I'd actually describe them: what I reach for first,
 * what I'm comfortable in, and what I've shipped with but wouldn't claim depth in.
 */
export type SkillDepth = 'core' | 'working' | 'familiar'

export type SkillGroup = {
  name: string
  items: { name: string; depth: SkillDepth; note?: string }[]
}

export const skillGroups: SkillGroup[] = [
  {
    name: 'Languages',
    items: [
      { name: 'Ruby', depth: 'core', note: 'Rails monolith, Sidekiq, a published gem' },
      { name: 'TypeScript', depth: 'core', note: 'NestJS services, Next.js' },
      { name: 'Go', depth: 'working', note: 'Notification service, an AST migration tool' },
      { name: 'Python', depth: 'working', note: 'ML serving, Lambdas, automation' },
      { name: 'Dart', depth: 'working', note: 'Flutter client' },
      { name: 'Bash', depth: 'working' },
      { name: 'SQL', depth: 'core' },
    ],
  },
  {
    name: 'Backend',
    items: [
      { name: 'Ruby on Rails', depth: 'core' },
      { name: 'NestJS', depth: 'core' },
      { name: 'Sidekiq', depth: 'core', note: '211 workers, ~28 queues in production' },
      { name: 'BullMQ', depth: 'working' },
      { name: 'Socket.IO', depth: 'core', note: 'Real-time messaging at fleet scale' },
      { name: 'Asynq', depth: 'working', note: 'Go job queue' },
      { name: 'Gin + GORM', depth: 'working' },
      { name: 'REST API design', depth: 'core' },
    ],
  },
  {
    name: 'Data & storage',
    items: [
      { name: 'MySQL', depth: 'core', note: 'Primary store behind the monolith' },
      { name: 'Redis', depth: 'core', note: 'Cache, queues, pub/sub, rate limiting, locks' },
      { name: 'MongoDB', depth: 'working', note: 'Message persistence' },
      { name: 'OpenSearch', depth: 'working', note: 'Post and hashtag indexing' },
      { name: 'PostgreSQL', depth: 'working' },
      { name: 'S3 / object storage', depth: 'core' },
    ],
  },
  {
    name: 'Infrastructure',
    items: [
      { name: 'Kubernetes', depth: 'core', note: 'Production fleet, multi-environment' },
      { name: 'Helm', depth: 'core' },
      { name: 'Terraform', depth: 'core', note: 'AWS, GCP and Azure estates' },
      { name: 'Docker', depth: 'core' },
      { name: 'KEDA', depth: 'working', note: 'Queue-depth autoscaling' },
      { name: 'Karpenter', depth: 'working', note: 'Node provisioning, spot capacity' },
      { name: 'Flux / ArgoCD', depth: 'working', note: 'GitOps reconciliation' },
      { name: 'APISIX', depth: 'familiar' },
    ],
  },
  {
    name: 'Cloud',
    items: [
      { name: 'AWS', depth: 'core', note: 'EKS, Lambda, RDS, S3, CloudFront, MediaConvert, OpenSearch' },
      { name: 'GCP', depth: 'working', note: 'GKE, Cloud Storage, Video Transcoder, Vertex AI' },
      { name: 'Azure', depth: 'working', note: 'AKS and Media Services — migrated off' },
    ],
  },
  {
    name: 'Delivery & observability',
    items: [
      { name: 'CircleCI', depth: 'core', note: 'Test parallelization, deploy pipelines' },
      { name: 'GitHub Actions', depth: 'core' },
      { name: 'New Relic', depth: 'core', note: 'APM, custom instrumentation, alerting' },
      { name: 'Prometheus + Grafana', depth: 'working' },
      { name: 'Loki', depth: 'working' },
      { name: 'Velero', depth: 'working', note: 'Cluster backup and restore drills' },
      { name: 'Jenkins', depth: 'familiar' },
    ],
  },
]

/**
 * Headline figures for the hero strip. Each one is derived from the repositories
 * and pull-request history, not estimated.
 */
export const stats = [
  { value: '~1,700', label: 'merged pull requests', detail: '1,621 of 1,741 opened, across 15 repositories' },
  { value: '4 yrs', label: 'on one platform', detail: 'Dec 2021 → present, same product' },
  { value: '24', label: 'services on the fleet', detail: 'Production AWS cluster, GitOps-managed' },
  { value: '3', label: 'clouds worked across', detail: 'AWS primary, GCP and Azure alongside' },
] as const
