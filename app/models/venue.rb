class Venue < ActiveRecord::Base
  # attr_accessible :title, :body
  has_one :item, :as => :details
  geocoded_by :address
  after_validation :geocode
end
