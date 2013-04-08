class AddPublishedAtToLinks < ActiveRecord::Migration
  def change
    add_column :links, :published_at, :timestamp
  end
end
