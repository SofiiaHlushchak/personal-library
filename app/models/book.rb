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
#  category_id    :bigint           not null
#
# Indexes
#
#  index_books_on_category_id  (category_id)
#  index_books_on_title        (title) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#

class Book < ApplicationRecord
  belongs_to :category

  validates :title, presence: { message: :blank }
  validates :author, presence: { message: :blank }
  validates :pages, presence: { message: :blank }
  validates :age_limit, presence: { message: :blank }
end
