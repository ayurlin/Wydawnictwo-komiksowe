class AddLinkToSlides < ActiveRecord::Migration[5.0]
  def change
    add_column :slides, :link, :string
  end
end
