class ImageController < ApplicationController
  def index
    @images = Image.all
  end
  
  def create
    @image = Image.create params[:image]
    redirect_to :back
  end
  
  def show
  end
  
  def new
    @image = Image.new
  end
  
end
