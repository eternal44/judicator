class ChangeReportTableNames < ActiveRecord::Migration[5.1]
  def change
    rename_table :comparison_groupings, :report_groupings
    rename_table :property_cashflow_reports, :reports

    rename_column :reports, :comparison_grouping_id, :report_grouping_id
    rename_column :cashflow_items, :property_cashflow_report_id, :report_id
  end
end
