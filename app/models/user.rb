class User < ActiveRecord::Base
  has_secure_password
  has_many :guests, dependent: :destroy #if a User is destroyed, all its associated guests will also be destroyed

  validates :first_name, :last_name, :username, :email, :password, presence: true, on: :create
  validates :username, uniqueness: true, on: :create

  extend Concerns::ClassMethods
  include Concerns::InstanceMethods
end
