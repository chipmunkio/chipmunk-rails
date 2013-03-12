class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :item_id
      t.string :link_type
      t.string :url
      t.integer :word_count
      t.timestamps
    end
  end
end
