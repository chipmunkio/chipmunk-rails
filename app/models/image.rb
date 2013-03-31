class Image < ActiveRecord::Base
  attr_accessible :asset
  has_attached_file :asset
  
  belongs_to :item
  
end
