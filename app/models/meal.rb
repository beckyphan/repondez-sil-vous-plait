class Meal < ActiveRecord::Base
  belongs_to :guest 
end
