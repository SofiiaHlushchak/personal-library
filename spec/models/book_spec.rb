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
require "rails_helper"

RSpec.describe Book, type: :model do
  let(:valid_attributes) { attributes_for(:book) }

  describe "validations" do
    it "is valid with valid attributes" do
      book = build(:book, valid_attributes)
      expect(book).to be_valid
    end

    it "is invalid without a title" do
      book = build(:book, title: "")
      book.valid?
      expect(book.errors[:title]).to include(I18n.t("activerecord.errors.models.book.attributes.title.blank"))
    end

    it "is invalid without an author" do
      book = build(:book, author: "")
      book.valid?
      expect(book.errors[:author]).to include(I18n.t("activerecord.errors.models.book.attributes.author.blank"))
    end

    it "is invalid without pages" do
      book = build(:book, pages: nil)
      book.valid?
      expect(book.errors[:pages]).to include(I18n.t("activerecord.errors.models.book.attributes.pages.blank"))
    end

    it "is invalid without an age limit" do
      book = build(:book, age_limit: nil)
      book.valid?
      expect(book.errors[:age_limit]).to include(I18n.t("activerecord.errors.models.book.attributes.age_limit.blank"))
    end
  end
end
