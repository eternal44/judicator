class City < ActiveRecord::Base
  has_many :properties
  has_many :zipcodes

  belongs_to :state
  belongs_to :county

  # validates :name, uniqueness: {case_sensitive: false}
end
