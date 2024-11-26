# frozen_string_literal: true

categories = Category.create!([
                                { name: "Classic" },
                                { name: "Fiction" },
                                { name: "Dystopian" },
                                { name: "Romance" },
                                { name: "Fantasy" }
                              ])

books = [
  {
    title: "The Great Gatsby",
    author: "F. Scott Fitzgerald",
    description: "A novel about the Jazz Age in the United States.",
    published_year: 1925,
    age_limit: 18,
    pages: 180,
    category_id: categories.find { |c| c.name == "Classic" }.id
  },
  {
    title: "To Kill a Mockingbird",
    author: "Harper Lee",
    description: "A novel about racial injustice in the American South.",
    published_year: 1960,
    age_limit: 15,
    pages: 281,
    category_id: categories.find { |c| c.name == "Fiction" }.id
  },
  {
    title: "1984",
    author: "George Orwell",
    description: "A dystopian novel set in a totalitarian society under constant surveillance.",
    published_year: 1949,
    age_limit: 16,
    pages: 328,
    category_id: categories.find { |c| c.name == "Dystopian" }.id
  },
  {
    title: "Pride and Prejudice",
    author: "Jane Austen",
    description: "A romantic novel that deals with issues of marriage, money, and love.",
    published_year: 1813,
    age_limit: 13,
    pages: 279,
    category_id: categories.find { |c| c.name == "Romance" }.id
  },
  {
    title: "The Hobbit",
    author: "J.R.R. Tolkien",
    description: "A fantasy novel about a hobbit's adventure to recover a stolen treasure.",
    published_year: 1937,
    age_limit: 10,
    pages: 310,
    category_id: categories.find { |c| c.name == "Fantasy" }.id
  }
]

books.each do |book_data|
  Book.create!(
    title: book_data[:title],
    author: book_data[:author],
    description: book_data[:description],
    published_year: book_data[:published_year],
    age_limit: book_data[:age_limit],
    pages: book_data[:pages],
    category_id: book_data[:category_id]
  )
end
