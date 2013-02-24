class Item < ActiveRecord::Base
  attr_accessible :name, :minutes, :img_url, :details_id, :details_type
  
  belongs_to :details, :polymorphic => true  
  
  default_scope select("id, name, minutes, img_url, details_type")
  default_scope order("minutes DESC, RANDOM()")
  
  scope :minutes, :location
   
  def self.minutes(minutes = nil)
    unless minutes.nil?
      where("minutes <= ?", minutes)
    end
  end
  
  def self.location(latitude, longitude)
    
  end
  
end
