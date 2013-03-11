class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :address
      t.decimal :latitutde
      t.decimal :longitude

      t.timestamps
    end
  end
end
