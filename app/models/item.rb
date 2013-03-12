class Item < ActiveRecord::Base
  attr_accessible :name, :minutes, :item_type, :link_attributes, :venue_attributes
    
  #belongs_to :details, :polymorphic => true  
  has_one :link
  has_one :venue
  
  accepts_nested_attributes_for :link
  accepts_nested_attributes_for :venue
    
  default_scope select("items.id AS id, items.name, items.minutes, items.item_type, venues.address, venues.latitude, venues.longitude, links.url, links.link_type")
  default_scope order("minutes DESC, RANDOM()")
  default_scope joins("LEFT OUTER JOIN Venues ON venues.item_id = items.id")
  default_scope joins("LEFT OUTER JOIN Links ON links.item_id = items.id")
  #default_scope where("latitude = '37.4339439' OR latitude IS NULL")
  
  scope :minutes
  scope :location
  scope :distance
  scope :page
      
  def self.page(page_num = 1)
    if page_num.nil?
      page_num = 0
    else
      page_num = page_num.to_i
      page_num = page_num - 1
    end
    offset_num = 10*page_num
    limit(10).offset(offset_num)
  end
   
  def self.minutes(minutes = nil)
    unless minutes.nil?
      where("minutes <= ?", minutes)
    end
  end
  
  def self.location(latitude, longitude)
    select(Geocoder::Sql.full_distance(latitude, longitude, "venues.latitude", "venues.longitude") + " AS distance")
  end
  
  def self.distance(miles) 
    where("distance <= #{miles} OR distance IS NULL")
  end
  
end
