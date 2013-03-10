class AddLatitudeToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :latitude, :decimal
  end
end
