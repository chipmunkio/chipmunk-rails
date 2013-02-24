class Venue < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :item_attributes
  
  has_one :item, :as => :details
  geocoded_by :address
  after_validation :geocode
  
  accepts_nested_attributes_for :item
end
