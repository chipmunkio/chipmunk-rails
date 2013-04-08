class Feed < ActiveRecord::Base
  # attr_accessible :title, :body
  
  def parse
    parser = FeedParser.new(self.url)
    parser.parser_type = self.parser
    parser.fetch
    parser.parse
    parser.add_items
    
    self.last_parsed = Time.now
    self.save
  end
  
end
