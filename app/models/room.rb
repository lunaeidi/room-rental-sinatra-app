class Room < ActiveRecord::Base
  validates :listing_title, :uniqueness => true, :presence => true
  belongs_to :user
end
