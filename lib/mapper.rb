class Mapper

  attr_accessor :onixp, :product, :a

  def initialize(onix_product)
    @onixp = onix_product
    @product = Book.where(record_reference: onixp.record_reference).first || Book.create!(record_reference: record_reference)
    @a = Metadata::Product.new
  end

  def get_product
    map_attributes

    @product.data = @a
    @product.save!

    @product.load_cover!
    @product.load_book_images!

    return @product
  end

  def map_attributes
    a.ean               = onixp.isbn13
    a.state             = onixp.current_state
    a.product_form      = "book"
    a.publishers        = [onixp.publisher_name]
    a.cover_type        = onixp.cover_type
    a.collection_name   = onixp.collection_title
    a.collection_part   = onixp.collection_part
    a.title             = onixp.title
    a.subtitle          = onixp.subtitle
    a.original_title    = onixp.original_title
    a.edition_statement = onixp.edition_statement
    set_series_membership
    a.number_of_pages   = onixp.number_of_pages
    a.description       = onixp.description ? onixp.description.text : ''
    set_contributors

    a.dimensions        = { width: onixp.width, height: onixp.height, thickness: onixp.thickness, weight: onixp.weight }
    a.pkwiu             = onixp.pkwiu
    a.cover_gross_price = (onixp.cover_price.to_d * 100).to_i
    a.shop_gross_price  = a.cover_gross_price - a.cover_gross_price / 10 
    a.vat               = onixp.vat
    a.premiere          = premiere

    a.has_preview       = onixp.preview_exists

    a.record_reference  = onixp.record_reference
    a.cover_url         = onixp.front_cover.link if onixp.front_cover
    a.additional_image_urls = (onixp.supporting_resources || []).find_all { |sr| sr.content_type_name == "sample_content" }.map(&:link)
  end

  def record_reference
    onixp.record_reference
  end

  def set_output_defaults
    a.authorship_kind = 'no_contributor'
  end

  def set_authorship(author, separator=',')
    if author.present?
      if collective_authorship? author 
        set_collective_authorship
      else author.present?
        add_contributor 'author', author, separator
      end
    end
  end

  def set_collective_authorship
    a.authorship_kind = 'collective'
  end

  def collective_authorship?(author_name)
    case author_name.downcase.gsub(' ', '')
    when 'pracazbiorowa', 'opracowaniezbiorowe'
      true
    else
      false
    end
  end

  def add_contributor(role, name, separator=',')
    a.authorship_kind = 'user_given'
    name.to_s.split(separator).each do |n|
      contributor = Metadata::Contributor.new(role_name: role, full_name: n.strip)
      a.contributors << contributor
    end
  end

  def add_series_membership(name, number=nil)
    object = Metadata::Series.new(name: name, number_within_series: number)
    a.series << object
  end

  def premiere
    {
      year:  onixp.parsed_publishing_date[0],
      month: onixp.parsed_publishing_date[1],
      day:   onixp.parsed_publishing_date[2],
    }
  end

  def set_series_membership
    onixp.series.each do |(name, number)|
      add_series_membership name, number
    end
  end

  def set_contributors
    if onixp.unnamed_persons?
      set_collective_authorship
    else
      onixp.contributors.each do |contributor|
        add_contributor contributor.role_name, contributor.person_name
      end
    end
  end
end
