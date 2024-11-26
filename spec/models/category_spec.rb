# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_categories_on_name  (name) UNIQUE
#
require "rails_helper"

RSpec.describe Category, type: :model do
  let!(:category) { create(:category) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  describe "associations" do
    let(:book) { create(:book, category: category) }

    it "should have many books" do
      expect(category.books).to include(book)
    end
  end
end
