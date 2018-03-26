class AddContact < ActiveRecord::Migration[5.1]
  def change
    add_column :rooms, :contact, :string
  end
end
