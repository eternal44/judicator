class PropertyClassification < ActiveRecord::Base
  has_many :properties

  # validates :name, uniqueness: {case_sensitive: false}
end
