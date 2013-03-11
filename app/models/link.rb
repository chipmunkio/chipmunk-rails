class Link < ActiveRecord::Base
  attr_accessible :link_type, :url, :item_id
  belongs_to :item, :foreign_key => "item_id"
end
