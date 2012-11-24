class User < ActiveRecord::Base
  attr_accessible :email, :username, :facebook_token
  
  has_many :friends
  
end
