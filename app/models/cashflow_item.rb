class CashflowItem < ActiveRecord::Base
  belongs_to :cashflow_type
  belongs_to :report
end
