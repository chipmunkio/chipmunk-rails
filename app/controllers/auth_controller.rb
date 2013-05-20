class AuthController < ApplicationController
  def index    
    user ||= params[:username]
    pass ||= params[:password]
    
    @user = User.find_by_username(user)
    
    if @user.nil?
      render :json => {:message => "Invalid username!"}, :status => 401
    else 
      @user.ensure_authentication_token!

      if @user.valid_password? pass
        render :json => {:token => @user.authentication_token}, :status => 200
      else
        render :json => {:message => "Invalid password!"}, :status => 401
      end
    end
    
    
    #render :json => @user
  end
  
end