class AddIconToSeries < ActiveRecord::Migration[5.0]
  def change
    add_column :series, :icon, :string
  end
end
