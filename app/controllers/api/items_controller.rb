class Api::ItemsController < ApplicationController
  def query 
    #@items = Item.find(:all, :select => "id, name, minutes, img_url, details_type")
    
    @items = Item.minutes(params[:minutes])
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
