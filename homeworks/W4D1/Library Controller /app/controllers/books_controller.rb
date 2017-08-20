class BooksController < ApplicationController
  before_action :set_book, only: [:destroy]

  def index
    # your code here
    @books = Book.all
  end

  def new
    # your code here
    @book = Book.new
  end

  def create
    # your code here
    book = Book.new(book_params)

    if book.save
      redirect_to books_url
    else
      flash[:errors] = book.errors.full_messages
      render :new
    end
  end

  def destroy
    # your code here
    @book.destroy
    redirect_to books_url
  end

  private
  def book_params
    params.require(:book).permit(:title, :author)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
