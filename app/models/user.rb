class User < ActiveRecord::Base
  has_many :guests
  validates :first_name, :last_name, :username, :email, :password, presence: true
end
