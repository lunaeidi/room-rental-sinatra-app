class Room < ActiveRecord::Base
  validates :listing_title, :uniqueness => true, :presence => true
  validates :cost, :presence => true
  validates :location, :presence => true
  validates :occupancy, :presence => true
  validates :contact, :presence => true 
  belongs_to :user
end
