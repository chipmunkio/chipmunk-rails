class AddItemIdToLinks < ActiveRecord::Migration
  def change
    add_column :links, :item_id, :integer
  end
end
