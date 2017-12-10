class AddCreatedAtUpdatedAtColumns < ActiveRecord::Migration
  def change_table
   ["cashflow_items",
   "cashflow_types",
   "cities",
   "comparison_groupings",
   "counties",
   "parking_types",
   "possession_types",
   "properties",
   "property_cashflow_reports",
   "property_classifications",
   "states",
   "statuses",
   "time_frames",
   "zipcodes"].each do |table|
     add_column table.to_sym, :created_at, :datetime, null: false
     add_column table.to_sym, :updated_at, :datetime, null: false
   end
  end
end
