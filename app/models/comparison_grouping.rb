class ComparisonGrouping < ActiveRecord::Base
  belongs_to :parking_type
  belongs_to :zipcode
  belongs_to :time_frame

  has_many :property_cashflow_reports
end
