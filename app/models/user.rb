class User < ActiveRecord::Base
  validates :email, :uniqueness => true, :presence => true
  validates :password, :uniqueness => true, :presence => true
  has_secure_password
  has_many :rooms
end
