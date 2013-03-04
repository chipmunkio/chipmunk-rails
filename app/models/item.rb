class Item < ActiveRecord::Base
  attr_accessible :name, :minutes, :img_url, :image, :details_id, :details_type
  
  #has_attached_file :image, :styles => { :full => "310x148>" }, :default_url => "/images/:style/missing.png"
  
  belongs_to :details, :polymorphic => true  
  
  default_scope select("id, name, minutes, img_url, details_type")
  default_scope order("minutes DESC, RANDOM()")
  
  scope :minutes
  scope :location
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
    
  end
  
end
