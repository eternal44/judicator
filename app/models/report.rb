class Report < ActiveRecord::Base
  belongs_to :property
  belongs_to :time_frame
  belongs_to :report_grouping
  belongs_to :possession_type

  has_many :cashflow_items
end
