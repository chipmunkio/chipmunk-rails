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
    source = "FeedSources::#{@parser_type}".constantize.new(@results.entries)
    source.process
    @urls = source.urls
  end
    
  def add_items
    @urls.each do |url|
      item = ItemBuilder.new
      item.link_url = url
      item.build
    end
  end
  
end