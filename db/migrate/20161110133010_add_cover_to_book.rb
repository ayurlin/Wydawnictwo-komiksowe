class AddCoverToBook < ActiveRecord::Migration[5.0]

  def up
    add_attachment :books, :cover
    add_column :books, :cover_url, :string
  end

  def down
    remove_attachment :books, :cover
    remove_column :books, :cover_url
  end
end
