class Meal < ActiveRecord::Base
  belongs_to :guest
  has_many :guests
  #to see how many of each meal a guest may have; build out this concept in future via a meals_controller

  validates :guest_id, presence: true, on: :create
end
