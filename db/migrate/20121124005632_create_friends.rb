class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :name
      t.string :location
      t.string :pic_url
      t.integer :user_id

      t.timestamps
    end
  end
end
