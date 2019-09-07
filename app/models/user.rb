class User < ActiveRecord::Base
  has_many :guests
  has_secure_password
  validates :first_name, :last_name, :username, :email, :password, presence: true
  validates :username, :email, uniqueness: true

  extend Concerns::ClassMethods
  include Concerns::InstanceMethods
end
