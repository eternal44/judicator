class State < ActiveRecord::Base
  has_many :zipcodes
  has_many :cities
  has_many :counties

  # validates :name, uniqueness: {case_sensitive: false}
end
