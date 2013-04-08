class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :url
      t.string :parser
      t.timestamp :last_parsed
      t.timestamps
    end
  end
end
