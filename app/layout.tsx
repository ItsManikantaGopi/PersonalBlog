import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import './globals.css'

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Manikanta Gopi - Software Engineer',
  description: 'DevOps | Backend Systems | Event-Driven Systems | CI/CD | Cloud (AWS, GCP, Azure) | Kubernetes | Terraform | Docker',
  keywords: ['Software Engineer', 'DevOps', 'Backend', 'Cloud', 'Kubernetes', 'Terraform', 'Docker', 'AWS', 'GCP', 'Azure'],
  authors: [{ name: 'Manikanta Gopi' }],
  openGraph: {
    title: 'Manikanta Gopi - Software Engineer',
    description: 'DevOps | Backend Systems | Event-Driven Systems | Cloud Infrastructure',
    type: 'website',
  },
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className={inter.className}>{children}</body>
    </html>
  )
}
