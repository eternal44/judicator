class CashflowItem < ActiveRecord::Base
  belongs_to :cashflow_type
  belongs_to :property_cashflow_report
end
