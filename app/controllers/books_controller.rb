# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :authenticate_user!, only: %i[new create index show]

  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: "Book was successfully created."
    else
      render turbo_stream: turbo_stream.replace("book_form", partial: "books/form", locals: { book: @book })
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :description, :pages, :age_limit, :published_year)
  end
end
