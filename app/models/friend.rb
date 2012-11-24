class Friend < ActiveRecord::Base
  attr_accessible :location, :name, :pic_url, :user_id, :facebook_id
  
  belongs_to :user
  
  acts_as_gmappable

  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    self.location
  end
  
  def gmaps4rails_infowindow
    "<img src='https://graph.facebook.com/#{self.facebook_id}/picture'>
     <p>#{self.name} is in #{self.location}</p>"
  end
  
end
