class AddEndDateToSlides < ActiveRecord::Migration[5.0]
  def change
    add_column :slides, :end_at, :date
  end
end
