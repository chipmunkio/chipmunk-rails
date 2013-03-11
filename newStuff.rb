class Api::ItemsController < ApplicationController
  def query 
    #@items = Item.find(:all, :select => "id, name, minutes, img_url, details_type")
    
    @items = Item.page(params[:page]).minutes(params[:minutes])

# the below block should join the details into the item
# I could not test because rails is not completely setup 
# on my computer -AC
=begin
    @items.map! { |x|
        details = {}
        if x.details_id == 'venue'
            details = Venue.find(x.details_id)
        elsif x.details_id == 'link'
            details = Link.find(x.details_id)
        end
        x.merge(details.attributes)
    }
=end
            
    render :json => @items
  end

  def index
    @items = Item.find_by_sql(
        'IF "items".details_type="venue"
        BEGIN
        SELECT name, minutes, img_url, image, details_type, url, link_type,
                address, latitude, longitude FROM "items" INNER JOIN
                "venues" ON "items".details_id="venues".id
        END
        ELSE
        BEGIN
        SELECT name, minutes, img_url, image, details_type, url, link_type,
                address, latitude, longitude FROM "items" INNER JOIN
                "links" ON "items".details_id="links".id
        END')
    render :json => @items
  end
  
  def show
    @item = Item.find params[:id]
    render :json => @item
    #@item = Item.find params[:id]
  end
  
  def new
    @link = Link.new
    @link.build_item
    
    @venue = Venue.new
    @venue.build_item
  end
  
  def create
    if (params[:link])
      Link.create params[:link]
    elsif (params[:venue])
      Venue.create params[:venue]
    end
    redirect_to :back
  end
end







class Item < ActiveRecord::Base
  attr_accessible :name, :minutes, :img_url, :image, :details_id, :details_type
  
  #has_attached_file :image, :styles => { :full => "310x148>" }, :default_url => "/images/:style/missing.png"
  
  belongs_to :details, :polymorphic => true, :foreign_key => "details_id"
  
  default_scope select("id, name, minutes, img_url, details_type")
  default_scope order("minutes DESC, RANDOM()")
  
  scope :minutes
  scope :location
  scope :page
  
  def self.page(page_num = 1)
    if page_num.nil?
      page_num = 0
    else
      page_num = page_num.to_i
      page_num = page_num - 1
    end
    offset_num = 10*page_num
    limit(10).offset(offset_num)
  end
   
  def self.minutes(minutes = nil)
    unless minutes.nil?
      where("minutes <= ?", minutes)
    end
  end
  
  def self.location(latitude, longitude)
    
  end
  
end



class Link < ActiveRecord::Base
  attr_accessible :url, :link_type, :item_attributes
  
  has_one :item, :as => :details
  
  accepts_nested_attributes_for :item
end




class Venue < ActiveRecord::Base
  attr_accessible :address, :latitude, :longitude, :item_attributes
  
  has_one :item, :as => :details
  geocoded_by :address
  after_validation :geocode
  
  accepts_nested_attributes_for :item
end

