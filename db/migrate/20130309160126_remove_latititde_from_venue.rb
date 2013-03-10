class RemoveLatititdeFromVenue < ActiveRecord::Migration
  def up
    remove_column :venues, :latitutde
  end

  def down
    add_column :venues, :latitutde, :decimal
  end
end
