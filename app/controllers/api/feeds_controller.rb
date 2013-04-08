class Api::FeedsController < ApplicationController
  respond_to :json, :xml
  
  def index
    @feeds = Feed.all
  end
  
  def show
    @feed = Feed.find params[:id]
  end
  
  def new
    @feed = Feed.new
  end
  
  def create
    @feed = Feed.create params[:feed]
    redirect_to :back
  end
  
  def parse
    @feed = Feed.find params[:id]
    @feed.parse
    redirect_to "/api/feeds/#{params[:id]}"
  end
  
end
