class BookSerializer
  def self.dump(data)
    data.to_hash.to_json
  end

  def self.load(hash)
    hash = JSON.parse(hash) if hash.is_a?(String)
    Metadata::Product.new(hash)
  end
end
