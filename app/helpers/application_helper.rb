module ApplicationHelper

  def book_path(book)
    "/#{book.id}-#{book.title.parameterize}"
  end
end
