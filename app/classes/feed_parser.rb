class FeedParser
  
  attr_accessor :feed_url
  attr_accessor :parser_type
    
  def initialize(feed_url)
    @parser = Feedzirra::Feed
    @feed_url = feed_url
    @parser_type = "Generic"
  end
    
  def fetch
    @results = @parser.fetch_and_parse(@feed_url)
  end
  
  def parse
    @source = "FeedSources::#{@parser_type}".constantize.new(@results.entries)
    @source.process
  end
    
  def add_items
    @source.add_items
  end
  
end