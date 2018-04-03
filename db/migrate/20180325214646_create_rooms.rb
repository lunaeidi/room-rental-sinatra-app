class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :listing_title, :unique => true, :null => false
      t.string :occupancy
      t.string :location
      t.decimal :cost
      t.integer :user_id
    end
  end
end
