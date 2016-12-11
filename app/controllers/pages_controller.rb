class PagesController < ApplicationController

  def index
    @books = Book.all
    @new_books = Book.all.find_all { |b| b.state == "published" }.sort_by(&:premiere_as_date).reverse.first(9)
    @announcement_books = Book.all.find_all { |book| book.state == "preorder" }.first(4)
    @series = Book.all.map { |b| [b.collection_name] + b.series.map(&:name) }.flatten.compact.uniq.sort
    @slides = Slide.active
    @displayed_series = Series.all.order(:position)
  end

  def preorders
    @announcement_books = Book.all.find_all { |book| book.state == "preorder" }.sort_by(&:premiere_as_date)
  end

  def products_list
    @books = Book.all.find_all.sort_by(&:premiere_as_date).reverse
    @results = Kaminari.paginate_array(@books).page(params[:strona]).per(15)
  end

  def foreign_rights
    @editors = Editor.find_by(name: 'Foreign Rights')
  end

  def contact
    @editors = Editor.find_by(name: 'Kontakt')
  end
  
  def by_series
    @books = Series.find_books(params[:id])
    render action: "products_list"
  end

  def author
    @authors_books = Book.all.find_all { |c| c.contributors.map { |c| c.full_name.parameterize }.include?(params[:id]) }.sort_by(&:premiere_as_date)
  end

end
