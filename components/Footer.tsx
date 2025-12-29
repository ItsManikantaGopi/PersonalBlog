import Link from 'next/link'

const socialLinks = [
  { name: 'GitHub', url: 'https://github.com/ItsManikantaGopi' },
  { name: 'LinkedIn', url: 'https://linkedin.com/in/manikanta-gopi' },
  { name: 'Twitter', url: 'https://twitter.com/ManikantaGopi' },
]

export default function Footer() {
  return (
    <footer className="footer">
      <div className="container footer-inner">
        <p className="footer-text">
          © {new Date().getFullYear()} Manikanta Gopi
        </p>
        <div className="social-links">
          {socialLinks.map((link) => (
            <a
              key={link.name}
              href={link.url}
              target="_blank"
              rel="noopener noreferrer"
              className="social-link"
            >
              {link.name}
            </a>
          ))}
        </div>
      </div>
    </footer>
  )
}
