class Api::ItemsController < ApplicationController
  def query 
    @poop = "ice cream"
    render :json => @poop
  end
end
