import { getAllHobbies } from '@/lib/hobbies'

export default function HobbiesPage() {
  const hobbies = getAllHobbies()

  return (
    <div className="container">
      <div className="page-header">
        <h1 className="page-title">Hobbies</h1>
        <p className="page-description">My drawings and creative work.</p>
      </div>

      {hobbies.length === 0 ? (
        <div>
          <p style={{ color: 'var(--gray-500)', marginBottom: '1rem' }}>
            No drawings yet. Add markdown files to <code>content/hobbies/</code> with the following format:
          </p>
          <pre style={{ 
            background: 'var(--gray-100)', 
            padding: '1rem', 
            fontSize: '0.875rem',
            overflow: 'auto'
          }}>
{`---
title: "Drawing Title"
description: "Description of the drawing"
image: "/images/drawing.jpg"
date: "2024-12-30"
---`}
          </pre>
        </div>
      ) : (
        <div className="gallery-grid">
          {hobbies.map((hobby) => (
            <div key={hobby.slug} className="gallery-item">
              {hobby.image ? (
                <img src={hobby.image} alt={hobby.title} />
              ) : (
                <div style={{ 
                  width: '100%', 
                  height: '100%', 
                  background: 'var(--gray-100)',
                  display: 'flex',
                  alignItems: 'center',
                  justifyContent: 'center',
                  color: 'var(--gray-400)'
                }}>
                  {hobby.title}
                </div>
              )}
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
