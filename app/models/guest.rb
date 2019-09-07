class Guest < ActiveRecord::Base
  belongs_to :user
  has_one :meal

  validates :first_name, :last_name, presence: true
end
