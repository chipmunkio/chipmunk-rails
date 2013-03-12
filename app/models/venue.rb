class Venue < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :item_attributes
  
  belongs_to :item
  
  geocoded_by :address
  after_validation :geocode
  
  accepts_nested_attributes_for :item
end
