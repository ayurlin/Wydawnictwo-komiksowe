class ImportProductsJob < ApplicationJob
  queue_as :normal

  def perform(*args)
    importer = Importer.new(API_LOGIN, API_PASSWORD)

    importer.fetch_products(true)
  end
end
