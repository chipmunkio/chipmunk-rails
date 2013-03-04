class TestController < ApplicationController
  def index
    @items = Item.page(1).minutes(30)
  end
end
