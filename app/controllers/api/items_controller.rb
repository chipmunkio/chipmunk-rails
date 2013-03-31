class Api::ItemsController < ApplicationController
  def query
    Item.reading_speed = 100
    @items = Item.page(params[:page]).item_type("Link").minutes(params[:minutes])
    
    render :json => @items
  end
  
  def show
    @item = Item.find params[:id]
    render :json => @item
    #@item = Item.find params[:id]
  end
  
  def last 
    @item = Item.first
    render :json => @item
  end
  
  def new
    @link = Link.new
    
    @venue = Venue.new
    @venue.build_item
  end
  
  def create
    if (params[:link])
      creation = Link.create params[:link]
    elsif (params[:venue])
      params[:venue][:item_attribute][:item_type] = "Venue"
      creation = Venue.create params[:venue]
    end
    redirect_to :back
  end
end
