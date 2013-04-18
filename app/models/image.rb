class Image < ActiveRecord::Base
  attr_accessible :asset
  has_attached_file :asset, :styles => {:regular => "320x220>", :retina => "640x440>", :square => "200x200#"}
  process_in_background :asset
  
  belongs_to :item
  
  def image_from_url=(url) 
    self.asset = URI.parse(url)
  end
  
end
