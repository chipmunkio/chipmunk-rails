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
    
  end
  
  class Longform < Generic
    
    def process
      @entries.each do |entry|
        noko = Nokogiri::HTML(entry.content)
        @urls << noko.css("a")[2]['href']
      end
    end
    
  end
  
end