class Guest < ActiveRecord::Base
  belongs_to :user
  has_one :meal, dependent: :destroy #if a guest is destroyed, its associated meal will also be destroyed

  validates :first_name, :last_name, presence: true
end
