import fs from 'fs'
import path from 'path'
import matter from 'gray-matter'

const hobbiesDirectory = path.join(process.cwd(), 'content/hobbies')

export interface Hobby {
  slug: string
  title: string
  description: string
  image: string
  date: string
}

export function getAllHobbies(): Hobby[] {
  if (!fs.existsSync(hobbiesDirectory)) {
    return []
  }
  
  const fileNames = fs.readdirSync(hobbiesDirectory)
  const allHobbies = fileNames
    .filter((name) => name.endsWith('.md'))
    .map((fileName) => {
      const slug = fileName.replace(/\.md$/, '')
      const fullPath = path.join(hobbiesDirectory, fileName)
      const fileContents = fs.readFileSync(fullPath, 'utf8')
      const { data } = matter(fileContents)

      return {
        slug,
        title: data.title || slug,
        description: data.description || '',
        image: data.image || '',
        date: data.date || '',
      }
    })

  return allHobbies.sort((a, b) => (a.date < b.date ? 1 : -1))
}
