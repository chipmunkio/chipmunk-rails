class FeedsController < ApplicationController
  respond_to :json, :xml, :html
  
  def index
    @feeds = Feed.all
  end
  
  def show
    @feed = Feed.find params[:id]
  end
  
  def new
    @feed = Feed.new
  end
  
  def edit
    @feed = Feed.find params[:id]
  end
  
  def create
    @feed = Feed.create params[:feed]
    redirect_to "/feeds"
  end
  
  def update
    @feed = Feed.find params[:id]
    @feed.attributes = params[:feed]
    @feed.save
    redirect_to "/feeds"
  end
  
  def destroy
    @feed = Feed.find params[:id]
    @feed.destroy
    redirect_to "/feeds"
  end
  
  def parse
    @feed = Feed.find params[:id]
    @feed.parse
    redirect_to "/feeds"
  end
  
end
