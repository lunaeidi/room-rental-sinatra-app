class AddPic < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :pic, :varbinary
  end
end
