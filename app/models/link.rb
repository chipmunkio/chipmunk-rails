class Link < ActiveRecord::Base
  attr_accessible :url, :link_type, :word_count, :item_attributes
  
  belongs_to :item
  
  accepts_nested_attributes_for :item
  
  before_create :get_url_details
  
  def get_url_details
    parser = Readit::Parser.new
    result = parser.parse self.url
        
    self.word_count = result.word_count
    
    item = Item.new
    item.name = result.title
    item.item_type = "Link"
    item.save
    
    self.item_id = item.id
  end
    
end
