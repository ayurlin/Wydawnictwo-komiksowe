Metadata = Module.new

VirtusJsonSchema::Generator.new('Product', ProductJson::SCHEMA, Metadata).generate!

class Object
  def metaclass
    class << self; self; end
  end
end

Metadata.constants.each do |const|
  klass = Metadata.const_get(const)
  klass.extend ActiveModel::Naming
  klass.include ActiveModel::Conversion
  klass.include ActiveModel::Validations
  klass.metaclass.instance_eval do
    define_method(:model_name) { ActiveModel::Name.new(klass, nil, const.to_s) }
  end
end

class Metadata::Series

  def self.required_attributes
    [:name]
  end

  def blank?
    name.blank?
  end
end

class Metadata::Contributor

  def self.required_attributes
    [:full_name]
  end

  def blank?
    full_name.blank?
  end
end


class Metadata::Product

  def remove_empty_objects!
    self.series = (self.series || []).find_all { |series| !series.blank? }
    self.series = nil if self.series.empty?
    self.contributors = (self.contributors || []).find_all { |contr| !contr.blank? }
    self.contributors = nil if self.contributors.empty?
    self.publishers = self.publishers.find_all { |p| p.present? }
  end

  def cover_gross_price_as_float
    if cover_gross_price
      ("%0.2f" % (BigDecimal(cover_gross_price.to_s) / 100)).gsub(".", ",")
    end
  end

  def cover_gross_price_as_float=(v)
    if v.present?
      self.cover_gross_price = (v.gsub(",", ".").to_f * 100).round
    else
      self.cover_gross_price = nil
    end
  end

  def publisher1
    publishers.first if publishers
  end

  def publisher2
    publishers.second if publishers
  end

  def publisher1=(v)
    self.publishers = [v]
  end

  def publisher2=(v)
    self.publishers << v
  end

end
