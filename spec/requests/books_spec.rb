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
      let(:category) { create(:category) }
      let(:book_params) { build(:book, category: category) }

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

  describe "DELETE /books/:id" do
    let(:admin) { create(:admin) }
    let(:user) { create(:user) }
    let!(:book) { create(:book) }

    context "when user is admin" do
      before { sign_in admin }

      it "deletes the book and responds with turbo stream" do
        expect do
          delete book_path(book), headers: { "Accept" => "text/vnd.turbo-stream.html" }
        end.to change(Book, :count).by(-1)

        expect(response.body).to include("<turbo-stream action=\"remove\" target=\"book_#{book.id}\">")
      end
    end

    context "when user is regular" do
      before { sign_in user }

      it "does not allow regular user to delete the book" do
        expect do
          delete book_path(book)
        end.to_not change(Book, :count)

        expect(response).to redirect_to(root_path)

        follow_redirect!

        expect(flash[:alert]).to include("You are not authorized to perform this action.")
      end
    end
  end
end
