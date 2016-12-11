class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :record_reference, null: false
      t.jsonb :data, default: {}

      t.timestamps
    end

    add_index :books, :record_reference, unique: true
  end
end
