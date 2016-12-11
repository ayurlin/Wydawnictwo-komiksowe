class AddStartDateToSlides < ActiveRecord::Migration[5.0]
  def change
    add_column :slides, :start_at, :date
  end
end
