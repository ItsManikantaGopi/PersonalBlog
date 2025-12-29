import { getAllBooks } from '@/lib/books'

export default function BooksPage() {
  const books = getAllBooks()

  return (
    <div className="container">
      <div className="page-header">
        <h1 className="page-title">Books</h1>
        <p className="page-description">Books I&apos;ve read and my thoughts on them.</p>
      </div>

      {books.length === 0 ? (
        <div>
          <p style={{ color: 'var(--gray-500)', marginBottom: '1rem' }}>
            No books yet. Add markdown files to <code>content/books/</code> with the following format:
          </p>
          <pre style={{ 
            background: 'var(--gray-100)', 
            padding: '1rem', 
            fontSize: '0.875rem',
            overflow: 'auto'
          }}>
{`---
title: "Book Title"
author: "Author Name"
notes: "My thoughts on the book"
rating: 5
date: "2024-12-30"
---`}
          </pre>
        </div>
      ) : (
        <div>
          {books.map((book) => (
            <div key={book.slug} className="book-card">
              <div className="book-cover" />
              <div className="book-info">
                <h3 className="book-title">{book.title}</h3>
                <p className="book-author">by {book.author}</p>
                {book.notes && <p className="book-notes">{book.notes}</p>}
                {book.rating > 0 && (
                  <p style={{ marginTop: '0.5rem', color: 'var(--gray-400)', fontSize: '0.875rem' }}>
                    {'★'.repeat(book.rating)}{'☆'.repeat(5 - book.rating)}
                  </p>
                )}
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
