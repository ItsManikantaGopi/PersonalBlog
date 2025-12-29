import fs from 'fs'
import path from 'path'
import matter from 'gray-matter'

const booksDirectory = path.join(process.cwd(), 'content/books')

export interface Book {
  slug: string
  title: string
  author: string
  notes: string
  rating: number
  date: string
}

export function getAllBooks(): Book[] {
  if (!fs.existsSync(booksDirectory)) {
    return []
  }
  
  const fileNames = fs.readdirSync(booksDirectory)
  const allBooks = fileNames
    .filter((name) => name.endsWith('.md'))
    .map((fileName) => {
      const slug = fileName.replace(/\.md$/, '')
      const fullPath = path.join(booksDirectory, fileName)
      const fileContents = fs.readFileSync(fullPath, 'utf8')
      const { data } = matter(fileContents)

      return {
        slug,
        title: data.title || slug,
        author: data.author || '',
        notes: data.notes || '',
        rating: data.rating || 0,
        date: data.date || '',
      }
    })

  return allBooks.sort((a, b) => (a.date < b.date ? 1 : -1))
}
