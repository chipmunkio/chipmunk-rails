class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.attachment :asset
      t.integer :item_id
      t.timestamps
    end
  end
end
