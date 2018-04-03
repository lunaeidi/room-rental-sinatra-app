class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email, :unique => true, :null => false
      t.string :password_digest
    end
  end
end
