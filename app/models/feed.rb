class Feed < ActiveRecord::Base
  attr_accessible :url, :parser
  
  before_save :format_parser
  
  def parse
    parser = FeedParser.new(self.url)
    parser.parser_type = self.parser
    parser.fetch
    #if (!parser.last_modified.nil? && parser.last_modified > self.last_parsed)
      parser.parse
      self.last_parsed = Time.now
      self.save
    #end
  end
  
  def format_parser
    if (self.parse == "") 
      self.parser = "Generic"
    end
    self.parser = self.parser.camelize
  end
  
end
