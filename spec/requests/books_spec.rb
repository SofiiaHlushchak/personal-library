# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Books", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe "GET /books" do
    let!(:book) { create(:book) }

    it "returns a successful response and displays books list" do
      get books_path

      expect(response).to have_http_status(:success)
      expect(response.body).to include(book.title)
    end
  end

  describe "GET /books/:id" do
    let(:book) { create(:book) }

    it "returns a successful response and displays book details" do
      get book_path(book)

      expect(response).to have_http_status(:success)
      expect(response.body).to include(book.title)
    end
  end

  describe "GET /books/new" do
    it "returns a successful response and displays the new book form" do
      get new_book_path

      expect(response).to have_http_status(:success)
      expect(response.body).to include("New Book")
    end
  end

  describe "POST /books" do
    context "with valid attributes" do
      let(:book_params) { build(:book) }

      it "creates a new book and redirects to the book show page" do
        post books_path, params: { book: book_params.attributes }

        expect(response).to redirect_to(book_path(Book.last))

        follow_redirect!

        expect(response.body).to include("Book was successfully created.")
      end
    end

    context "with invalid attributes" do
      it "does not create a new book and shows error messages" do
        invalid_params = { title: "", author: "", pages: nil, age_limit: nil }

        post books_path, params: { book: invalid_params }

        expect(response.body).to include('<turbo-stream action="replace" target="book_form">')

        expect(CGI.unescapeHTML(response.body)).to include("Please provide the book's title")
        expect(CGI.unescapeHTML(response.body)).to include("Please specify the author's name")
        expect(response.body).to include("Please enter a value")
        expect(response.body).to include("Please enter an age limit")
      end
    end
  end
end
