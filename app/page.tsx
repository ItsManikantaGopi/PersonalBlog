'use client'

import { useState, useEffect, useRef } from 'react'
import Image from 'next/image'

export default function Home() {
  const [isLoaded, setIsLoaded] = useState(false)
  const [typedText, setTypedText] = useState('')
  const fullText = "Hi, I'm Manikanta"
  const typingSpeed = 80

  useEffect(() => {
    setIsLoaded(true)
    
    // Typewriter effect
    let currentIndex = 0
    const typeInterval = setInterval(() => {
      if (currentIndex <= fullText.length) {
        setTypedText(fullText.slice(0, currentIndex))
        currentIndex++
      } else {
        clearInterval(typeInterval)
      }
    }, typingSpeed)

    return () => clearInterval(typeInterval)
  }, [])

  const skills = [
    { name: 'Kubernetes', category: 'infrastructure' },
    { name: 'Terraform', category: 'infrastructure' },
    { name: 'Docker', category: 'infrastructure' },
    { name: 'AWS', category: 'cloud' },
    { name: 'GCP', category: 'cloud' },
    { name: 'Azure', category: 'cloud' },
    { name: 'Python', category: 'languages' },
    { name: 'NestJS', category: 'languages' },
    { name: 'Ruby on Rails', category: 'languages' },
    { name: 'CI/CD', category: 'devops' },
    { name: 'GitOps', category: 'devops' },
    { name: 'Prometheus', category: 'monitoring' },
    { name: 'Grafana', category: 'monitoring' },
    { name: 'Redis', category: 'databases' },
    { name: 'MongoDB', category: 'databases' },
    { name: 'MySQL', category: 'databases' },
  ]

  const socialLinks = [
    {
      name: 'GitHub',
      url: 'https://github.com/ItsManikantaGopi',
      icon: (
        <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
          <path fillRule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z" clipRule="evenodd" />
        </svg>
      ),
    },
    {
      name: 'LinkedIn',
      url: 'https://linkedin.com/in/manikanta-gopi',
      icon: (
        <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
          <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
        </svg>
      ),
    },
    {
      name: 'Twitter',
      url: 'https://twitter.com/ManikantaGopi',
      icon: (
        <svg className="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
          <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>
        </svg>
      ),
    },
    {
      name: 'Email',
      url: 'mailto:manikanta.gopi@example.com',
      icon: (
        <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
        </svg>
      ),
    },
  ]

  return (
    <main className="min-h-screen relative">
      {/* Background effects */}
      <div className="hero-gradient" />
      <div className="grid-overlay" />
      <div className="noise-overlay" />
      
      {/* Animated orbs */}
      <div className="orb orb-1" />
      <div className="orb orb-2" />
      <div className="orb orb-3" />

      {/* Main content */}
      <div className="relative z-10">
        {/* Hero Section */}
        <section className="min-h-screen flex items-center justify-center px-4 sm:px-6 lg:px-8">
          <div className="max-w-7xl mx-auto w-full">
            <div className="grid lg:grid-cols-2 gap-12 lg:gap-20 items-center">
              
              {/* Left Column - Content */}
              <div className="space-y-8 text-center lg:text-left order-2 lg:order-1">
                {/* Greeting */}
                <div className={`space-y-4 ${isLoaded ? 'animate-fade-up' : 'opacity-0'}`}>
                  <p className="text-sm uppercase tracking-[0.3em] text-cyan-400 font-medium">
                    Welcome to my portfolio
                  </p>
                  <h1 className="text-4xl sm:text-5xl md:text-6xl lg:text-7xl font-bold leading-tight">
                    <span className="text-gradient-subtle">{typedText}</span>
                    <span className="typewriter-cursor" />
                  </h1>
                </div>

                {/* Role badge */}
                <div className={`${isLoaded ? 'animate-fade-up stagger-2' : 'opacity-0'}`}>
                  <div className="inline-flex items-center gap-3 glass-card px-5 py-3">
                    <div className="w-2 h-2 rounded-full bg-emerald-400 animate-pulse" />
                    <span className="text-lg sm:text-xl font-semibold text-gradient">
                      Software Engineer
                    </span>
                  </div>
                </div>

                {/* Description */}
                <p className={`text-lg sm:text-xl text-gray-400 max-w-xl mx-auto lg:mx-0 leading-relaxed ${isLoaded ? 'animate-fade-up stagger-3' : 'opacity-0'}`}>
                  Crafting scalable <span className="text-cyan-400">backend systems</span>, 
                  orchestrating <span className="text-purple-400">cloud infrastructure</span>, 
                  and building <span className="text-pink-400">event-driven architectures</span> that power modern applications.
                </p>

                {/* Skills grid */}
                <div className={`${isLoaded ? 'animate-fade-up stagger-4' : 'opacity-0'}`}>
                  <div className="flex flex-wrap gap-2 justify-center lg:justify-start">
                    {skills.map((skill, index) => (
                      <span
                        key={skill.name}
                        className="skill-pill"
                        style={{ animationDelay: `${index * 50}ms` }}
                      >
                        {skill.name}
                      </span>
                    ))}
                  </div>
                </div>

                {/* CTA and Social */}
                <div className={`flex flex-col sm:flex-row items-center gap-6 justify-center lg:justify-start ${isLoaded ? 'animate-fade-up stagger-5' : 'opacity-0'}`}>
                  {/* Social links */}
                  <div className="flex items-center gap-3">
                    {socialLinks.map((link) => (
                      <a
                        key={link.name}
                        href={link.url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="social-btn"
                        aria-label={link.name}
                      >
                        {link.icon}
                      </a>
                    ))}
                  </div>

                  {/* Resume button */}
                  <a 
                    href="#" 
                    className="group relative inline-flex items-center gap-2 px-6 py-3 overflow-hidden rounded-xl bg-gradient-to-r from-cyan-500 to-purple-600 text-white font-semibold transition-all duration-300 hover:scale-105 hover:shadow-[0_0_40px_rgba(0,212,255,0.4)]"
                  >
                    <span className="relative z-10">View Resume</span>
                    <svg className="w-4 h-4 relative z-10 transition-transform group-hover:translate-x-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M17 8l4 4m0 0l-4 4m4-4H3" />
                    </svg>
                    <div className="absolute inset-0 bg-gradient-to-r from-purple-600 to-cyan-500 opacity-0 group-hover:opacity-100 transition-opacity duration-300" />
                  </a>
                </div>
              </div>

              {/* Right Column - Profile Image */}
              <div className={`flex justify-center order-1 lg:order-2 ${isLoaded ? 'animate-fade-up' : 'opacity-0'}`}>
                <div className="relative animate-floating">
                  {/* Outer glow */}
                  <div className="absolute inset-0 bg-gradient-to-r from-cyan-500 via-purple-500 to-pink-500 rounded-full blur-3xl opacity-30 scale-110" />
                  
                  {/* Profile container */}
                  <div className="profile-glow">
                    <div className="relative w-64 h-64 sm:w-72 sm:h-72 md:w-80 md:h-80 lg:w-96 lg:h-96 rounded-full overflow-hidden">
                      <Image
                        src="https://avatars.githubusercontent.com/u/58616351?v=4"
                        alt="Manikanta Gopi"
                        fill
                        className="object-cover"
                        priority
                      />
                    </div>
                  </div>

                  {/* Floating badges */}
                  <div className="absolute -top-4 -right-4 glass-card glass-card-hover px-4 py-2 animate-bounce" style={{ animationDuration: '3s' }}>
                    <span className="text-sm font-medium text-cyan-400">DevOps</span>
                  </div>
                  <div className="absolute -bottom-2 -left-4 glass-card glass-card-hover px-4 py-2 animate-bounce" style={{ animationDuration: '3.5s', animationDelay: '0.5s' }}>
                    <span className="text-sm font-medium text-purple-400">Cloud</span>
                  </div>
                  <div className="absolute top-1/2 -right-8 glass-card glass-card-hover px-4 py-2 animate-bounce" style={{ animationDuration: '4s', animationDelay: '1s' }}>
                    <span className="text-sm font-medium text-pink-400">Backend</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </section>

        {/* Scroll indicator */}
        <div className="absolute bottom-8 left-1/2 -translate-x-1/2 flex flex-col items-center gap-2 text-gray-500">
          <span className="text-xs uppercase tracking-wider">Scroll</span>
          <div className="w-5 h-8 border-2 border-gray-600 rounded-full flex justify-center pt-1.5">
            <div className="w-1 h-2 bg-cyan-400 rounded-full animate-bounce" />
          </div>
        </div>

        {/* Footer */}
        <footer className="relative z-10 border-t border-white/5 mt-20">
          <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
            <div className="flex flex-col md:flex-row items-center justify-between gap-6">
              <div className="flex items-center gap-3">
                <div className="w-10 h-10 rounded-xl bg-gradient-to-r from-cyan-500 to-purple-600 flex items-center justify-center text-white font-bold">
                  MG
                </div>
                <div>
                  <p className="font-semibold text-white">Manikanta Gopi</p>
                  <p className="text-sm text-gray-500">Software Engineer</p>
                </div>
              </div>

              <div className="flex items-center gap-6">
                {socialLinks.map((link) => (
                  <a
                    key={link.name}
                    href={link.url}
                    target="_blank"
                    rel="noopener noreferrer"
                    className="text-gray-500 hover:text-cyan-400 transition-colors"
                    aria-label={link.name}
                  >
                    {link.icon}
                  </a>
                ))}
              </div>

              <p className="text-sm text-gray-600">
                © {new Date().getFullYear()} Built with{' '}
                <span className="text-gradient">Next.js & Tailwind</span>
              </p>
            </div>
          </div>
        </footer>
      </div>
    </main>
  )
}
