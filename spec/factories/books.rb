# frozen_string_literal: true

# == Schema Information
#
# Table name: books
#
#  id             :bigint           not null, primary key
#  age_limit      :integer          not null
#  author         :string           not null
#  description    :text
#  pages          :integer          not null
#  published_year :integer
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_books_on_title  (title) UNIQUE
#
FactoryBot.define do
  factory :book do
    title { "Sample Book" }
    author { "Sample Author" }
    pages { 200 }
    age_limit { 12 }
    description { "A sample description for the book." }
    published_year { 2020 }
  end
end
