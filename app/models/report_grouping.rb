class ReportGrouping < ActiveRecord::Base
  belongs_to :parking_type
  belongs_to :zipcode
  belongs_to :time_frame

  has_many :reports
end
