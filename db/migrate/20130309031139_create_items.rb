class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :minutes
      t.string :img_url
      t.string :details_type

      t.timestamps
    end
  end
end
