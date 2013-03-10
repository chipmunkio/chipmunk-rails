class Venue < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :item_id
  belongs_to :item, :foreign_key => "item_id"
end
