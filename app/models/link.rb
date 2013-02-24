class Link < ActiveRecord::Base
  attr_accessible :url, :link_type, :item_attributes
  
  has_one :item, :as => :details
  
  accepts_nested_attributes_for :item
end
