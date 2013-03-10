class Item < ActiveRecord::Base
  attr_accessible :details_type, :img_url, :minutes, :name
  has_one :link
  has_one :venue
end
