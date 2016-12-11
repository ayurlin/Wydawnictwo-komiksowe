class CreateBookImages < ActiveRecord::Migration[5.0]
  def change
    create_table :book_images do |t|
      t.integer :book_id, null: false
      t.string  :link, null: false
      t.attachment :file
      t.timestamps
    end

    add_index :book_images, :book_id
  end
end
