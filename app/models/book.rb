class Book < ApplicationRecord
  include ActionView::Helpers::SanitizeHelper
  include ActionView::Helpers::TextHelper 

  has_attached_file :cover, styles: { thumb: "300x",
                                      big:   "800x" }
  validates_attachment :cover, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }


  has_many :book_images ,-> { order(:id) }

  serialize :data, BookSerializer

  delegate :ean,                        #isbn bez kresek
           :state,                      #status: published, out_of_print albo preorder
           :publishers,                 #wydawnictwa
           :cover_type,                 #typ okładki
           :collection_name,            #nazwa kolekcji
           :collection_part,            #numer w kolekcji
           :title,                      #tytuł
           :subtitle,                   #podtytuł
           :original_title,             #tytuł originału
           :edition_statement,          #numer wydania
           :contributors,               #twórcy
           :series,                     #lista serii
           :number_of_pages,            #liczba stron
           :description,                #opis (html)
           :dimensions,                 #wymiary ksiązki
           :cover_gross_price_as_float, #cena okładkowa
           :premiere,                   #data premiery
           :additional_image_urls,      #dodatkowe ilustracje
           :categories,                 #kategorie
           :audience_age,               #wiek czytelnika
           to: :data


  def has_preview?
    data.has_preview
  end

  def short_description
    truncate(strip_tags(description.to_s).strip.gsub(/[\r\n\t]+/, " "), length: 250)
  end


  def preview_path
    stamp = Time.now.to_i.to_s
    sig = CGI.escape(Base64.encode64("#{OpenSSL::HMAC.digest('sha1', PREVIEW_SECRET_TOKEN, stamp)}").strip)
    "http://p.elibri.com.pl/book.js?record_reference=#{self.record_reference}&stamp=#{stamp}&token=#{PREVIEW_TOKEN}&sig=#{sig}"
  end

  def load_cover!
    if self.cover_url != self.data.cover_url
      #to znak, że okładka musi zostać na nowo załadowana
      self.cover = URI.parse(self.data.cover_url)
      self.cover_url = self.data.cover_url
      self.save!
    end
  end

  def load_book_images!
    if book_images.map(&:link) != self.data.additional_image_urls
      book_images.each { |i| i.destroy }
      self.data.additional_image_urls.each do |link|
        book_images.create!(link: link, file: URI.parse(link))
      end
    end
  end

  def authors
    contributors.select{|a| a.role_name == "author"}.map { |author| author['full_name'] }
  end

  def self.authors_by_surname
    authors = []
    Book.all.each do |book|
      authors << book.authors.map do |author|
        name = author.split
        if name.size > 1
          name.unshift(name.delete(name.last) + ', ').join
        else
          name.first
        end    
      end
    end
    authors.flatten.uniq.sort
  end

  def premiere_as_date
    if premiere
      Date.new(premiere.year || 2000, premiere.month || 6, premiere.day || 15)
    else
      10.years.ago
    end
  end

  def size
    dimensions.height.to_s + 'x' + dimensions.width.to_s
  end
   
end
