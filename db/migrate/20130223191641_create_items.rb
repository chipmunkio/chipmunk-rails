class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :item_type
      t.string :name
      t.integer :minutes
      t.timestamps
    end
  end
end
