class Link < ActiveRecord::Base
  attr_accessible :url, :link_type, :item_attributes
  
  belongs_to :item
  
  accepts_nested_attributes_for :item
end
