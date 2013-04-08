class Api::ItemsController < ApplicationController
  respond_to :json, :xml
  
  def index
    @items = Item.unscoped.order("id DESC")
    render "query"
  end
  
  def query
    @items = Item.page(params[:page]).item_type("Link").minutes(params[:minutes])
    
    #render :json => @items
  end
  
  def show
    @item = Item.find params[:id]
  end
  
  def last 
    @item = Item.first
    render :json => @item
  end
  
  def url
    @item = Item.find params[:id]
    redirect_to @item.url
  end
  
  def read
    @item = Item.find params[:id]
    parser = Readit::Parser.new
    @article = parser.parse @item.url
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
