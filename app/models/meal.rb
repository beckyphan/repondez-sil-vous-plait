class Meal < ActiveRecord::Base
  belongs_to :guest

  validates :guest_id, presence: true, on: :create
end
