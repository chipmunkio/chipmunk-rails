class ItemBuilder 
  attr_accessor :link_url
  attr_accessor :image_url
  attr_accessor :published_at
  
  def initialize
    @item = Item.new
    @image = Image.new
    @link = Link.new
  end
  
  def build_link    
    unless (Link.exists?(:url => @link_url))
      result = parse_url(@link_url)
      
      @item.name = result.title
      @item.item_type = "Link"
      @item.save
    
      @link.item_id = @item.id
      @link.url = @link_url
      @link.published_at = self.published_at || result.date_published
      @link.word_count = result.word_count
      @link.save
    
      unless (result.lead_image_url.nil? && self.image_url.nil?)
        @image.item_id = @item.id
        @image.image_from_url = self.image_url || result.lead_image_url
        @image.save
      end
    end
  end
  
  def build
    build_link
  end
  
  protected 
  
  def parse_url(url)
    parser = Readit::Parser.new
    parser.parse link_url
  end
  
end