module FeedSources
  
  class Generic
    attr_reader :urls
    attr_accessor :entries
        
    def initialize(entries)
      @entries = entries
    end
    
    def process
      @entries.each do |entry|
        item = OpenStruct.new
        item.url = entry.url
        item.published = entry.published
        add_item(item)
      end
    end
    
    protected
    
    def add_item(entry)
      item = ItemBuilder.new
      item.link_url = entry.url
      item.published_at ||= entry.published
      item.image_url ||= entry.image
      item.build
    end
    
  end
  
  class Longform < Generic
    
    def process
      @entries.each do |entry|
        item = OpenStruct.new
        noko = Nokogiri::HTML(entry.content)
        item.published = entry.published
        item.url = noko.css("a")[2]['href']
        add_item(item)
      end
    end
    
  end
  
  class Medium < Generic
    
    def process
      @entries.each do |entry|
        item = OpenStruct.new
        noko = Nokogiri::HTML(entry.summary)
        item.url = entry.url
        item.published = entry.published
        item.image ||= URI(noko.css("img")[0])
        add_item(item)
      end
    end
        
  end
  
  
end