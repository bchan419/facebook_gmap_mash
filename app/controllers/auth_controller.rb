require 'open-uri'

class AuthController < ApplicationController

  def facebook
    redirect_url = "http://localhost:3000/auth/facebook"
    facebook_login_url = "https://www.facebook.com/dialog/oauth?client_id=#{FACEBOOK_APP_ID}&redirect_uri=#{redirect_url}&response_type=code"

    user_code = params[:code]
    uri = "https://graph.facebook.com/oauth/access_token?client_id=#{FACEBOOK_APP_ID}&redirect_uri=#{redirect_url}&client_secret=#{FACEBOOK_APP_SECRET}&code=#{user_code}"
       
    @response = open(uri).read
    @token = @response.split("&").first.split("=").last

    logger.info "current user = #{current_user}"
    
    current_user.facebook_token = @token
    current_user.save     
    
    session[:facebook_connected] = true      
    
    token = @user.facebook_token

    # Get the list of friends and their current locations
    if current_user.facebook_token
      friends_url = "https://graph.facebook.com/me/friends?fields=name,location&access_token=#{token}"
      response = open(friends_url).read
      json = JSON.parse(response)
      @friends_list = json["data"]
      
      @friends_list.each do |friend|
        if friend["location"] && friend["location"]["name"]
          current_user.friends.create name: friend["name"], location: friend["location"]["name"], facebook_id: friend["id"]
        end
      end      
    end
    
    redirect_to user_url(current_user.id)
    
  end

end
