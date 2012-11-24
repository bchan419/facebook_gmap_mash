class AddFacebookIdtoFriend < ActiveRecord::Migration
  def up
    add_column :friends, :facebook_id, :string    
  end

  def down
  end
end
