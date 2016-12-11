class Series < ApplicationRecord
  mount_uploader :icon, IconUploader
  acts_as_list

  def self.find_books(series_name_parameterized)
    @books = Book.all.find_all { |b| b.collection_name.to_s.parameterize == series_name_parameterized ||
                                     b.series.map(&:name).map(&:parameterize).include?(series_name_parameterized) }.sort_by(&:premiere_as_date)
  end

  def books
    self.class.find_books(self.name.parameterize)
  end
end
