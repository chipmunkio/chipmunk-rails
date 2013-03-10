class AddItemIdToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :item_id, :integer
  end
end
