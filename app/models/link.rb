class Link < ActiveRecord::Base
  attr_accessible :url, :link_type, :word_count, :published_at
  
  belongs_to :item
    
  /
  before_create :get_url_details, :if => :url_is_only_attr
  
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
  
  def url_is_only_attr
    true
  end
   /
end
