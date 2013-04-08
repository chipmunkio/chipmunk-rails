module FeedSources
  
  class Generic
    attr_reader :urls
    attr_accessor :entries
        
    def initialize(entries)
      @entries = entries
      @urls = Array.new
    end
    
    def process
      @entries.each do |entry|
        @urls << entry.url
      end
    end
    
    def add_items
      @urls.each do |url|
        item = ItemBuilder.new
        item.link_url = url
        item.build
      end
    end
    
  end
  
  class Longform < Generic
    
    def process
      @entries.each do |entry|
        noko = Nokogiri::HTML(entry.content)
        @urls << noko.css("a")[2]['href']
      end
    end
    
  end
  
  class Medium < Generic
    
    def process
      @processed = Array.new
      @entries.each do |entry|
        processed = Hash.new
        noko = Nokogiri::HTML(entry.content)
        processed[:url] = entry.url
        processed[:image] = noko.css("img")['src']
        @processed << processed
      end
    end
    
    def add_items
      @processed.each do |processed|
        item = ItemBuilder.new
        item.link_url = processed[:url]
        item.image_url = processed[:image]
        item.build
      end
    end
    
  end
  
  
end