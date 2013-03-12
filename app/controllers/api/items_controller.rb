class Api::ItemsController < ApplicationController
  def query     
    @items = Item.page(params[:page]).item_type("Link").minutes(params[:minutes])
    
    render :json => @items
  end
  
  def show
    @item = Item.find params[:id]
    render :json => @item
    #@item = Item.find params[:id]
  end
  
  def new
    @link = Link.new
    
    @venue = Venue.new
    @venue.build_item
  end
  
  def create
    if (params[:link])
      Link.create params[:link]
    elsif (params[:venue])
      params[:venue][:item_attribute][:item_type] = "Venue"
      Venue.create params[:venue]
    end
    redirect_to :back
  end
end
