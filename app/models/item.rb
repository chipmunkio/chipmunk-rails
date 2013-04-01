class Item < ActiveRecord::Base
  attr_accessible :name, :item_type, :link_attributes, :venue_attributes
  
  @@reading_speed = 200
    
  #belongs_to :details, :polymorphic => true  
  has_one :link
  has_one :venue
  has_one :image
  
  accepts_nested_attributes_for :link
  accepts_nested_attributes_for :venue
      
  default_scope select("items.id AS id, items.name, items.item_type, venues.address, venues.latitude, venues.longitude, links.url, links.link_type, links.word_count")
  default_scope select("((links.word_count / #{@@reading_speed}) + 1) AS minutes")
  default_scope select("'http://spncr.me/NwoZ/content' AS img_url")
  #default_scope select("5 as minutes")
  default_scope order("((links.word_count / #{@@reading_speed}) + 1) DESC, RANDOM()")
  default_scope joins("LEFT OUTER JOIN Venues ON venues.item_id = items.id")
  default_scope joins("LEFT OUTER JOIN Links ON links.item_id = items.id")
           
  def self.minutes(minutes)
    where("((links.word_count / #{@@reading_speed}) + 1) <= ?", minutes.to_i)
  end
  
  def self.location(latitude, longitude)
    select(Geocoder::Sql.approx_distance(latitude, longitude, "venues.latitude", "venues.longitude") + " AS distance")
  end
  
  def self.distance(miles) 
    where("distance <= #{miles} OR distance IS NULL")
  end
  
  def self.item_type(item_type)
    where("item_type = ?", item_type)
  end
    
  def self.reading_speed=(wpm)
    @@reading_speed = wpm
    #select("((links.word_count / #{wpm}) + 1) AS minutes")
  end
  
end