class Feed < ActiveRecord::Base
  attr_accessible :url, :parser
  
  before_save :format_parser
  
  def self.parse_if_not_parsed_since(time)
    feeds = where("last_parsed < ?", time)
    feeds.each do |feed|
      feed.parse
    end
  end
  
  def parse
    parser = FeedParser.new(self.url)
    parser.parser_type = self.parser
    parser.fetch
    parser.parse
    self.last_parsed = Time.now
    self.save
  end
  handle_asynchronously :parse
  
  def format_parser
    if (self.parser == "") 
      self.parser = "Generic"
    end
    self.parser = self.parser.camelize
  end
  
end
