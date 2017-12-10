class CashflowType < ActiveRecord::Base
  belongs_to :time_frame

  has_many :cashflow_items

  # validates :name, uniqueness: {case_sensitive: false}
end
