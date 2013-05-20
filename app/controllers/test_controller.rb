class TestController < ApplicationController
  def index
    #@items = Item.page(1).minutes(30)
  end
  
  def read 
    @parser = Readit::Parser.new
    @result = @parser.parse "https://medium.com/this-happened-to-me/84d54292deee"
    
    render :json => @result
    
  end
end
