class County < ActiveRecord::Base
  has_many :zipcodes
  has_many :cities

  belongs_to :state

  # validates :name, uniqueness: {case_sensitive: false}
end
