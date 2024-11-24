# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :authenticate_user!, only: %i[new create index show]
  before_action :set_book, only: %i[show destroy]

  def index
    @books = Book.all
  end

  def show
    @book
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

  def destroy
    authorize @book

    if @book.destroy
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@book) }
        format.html { redirect_to books_path, notice: "Book was successfully deleted." }
      end
    else
      respond_to do |format|
        format.html { redirect_to books_path, alert: "There was an error deleting the book." }
      end
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :author, :description, :pages, :age_limit, :published_year)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
