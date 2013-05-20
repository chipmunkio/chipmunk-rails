class User < ActiveRecord::Base
  
  before_save :ensure_authentication_token
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :trackable
  # :lockable, :timeoutable and :omniauthable
  devise :uid, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
end
