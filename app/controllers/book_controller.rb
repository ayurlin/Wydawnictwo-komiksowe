class BookController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @meta.title = "#{@book.title} - Wydawnictwo komiksowe"
    @meta.keywords = "#{@book.title}, komiks"
    @meta.description = @book.short_description
  end

  def preview
    @book = Book.find(params[:id])
  end
end
