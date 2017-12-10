class Zipcode < ActiveRecord::Base
  has_many :properties

  belongs_to :city
  belongs_to :county
  belongs_to :state

  # validates :code, uniqueness: true
end
