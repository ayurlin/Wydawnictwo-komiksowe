class AddPositionToSeries < ActiveRecord::Migration[5.0]
  def change
    add_column :series, :position, :integer
  end
end
