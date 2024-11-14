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

class Book < ApplicationRecord
  validates :title, presence: { message: :blank }
  validates :author, presence: { message: :blank }
  validates :pages, presence: { message: :blank }
  validates :age_limit, presence: { message: :blank }
end
