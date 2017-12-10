class AddCashflowReportModelAndAssociations < ActiveRecord::Migration
  def change
    create_table :property_cashflow_reports do |t|
      t.integer :list_price, null: false
      t.integer :days_on_market
      t.boolean :is_short_sale

      t.integer :property_id, null: false
      t.integer :time_frame_id, null: false
      t.integer :comparison_grouping_id, null: false
      t.integer :possession_type_id, null: false
    end

    create_table :possession_types do |t|
      t.string :name, null: false
    end

    create_table :cashflow_items do |t|
      t.integer :amount, null: false

      t.integer :cashflow_type_id, null: false
      t.integer :property_cashflow_report_id, null: false
    end

    create_table :cashflow_types do |t|
      t.string :name, null: false
      t.boolean :debit
      t.boolean :credit

      t.integer :time_frame_id, null: false
    end

    create_table :parking_types do |t|
      t.string :name, null: false
    end

    create_table :time_frames do |t|
      t.string :name, null: false
    end

    create_table :comparison_groupings do |t|
      t.integer :bed_count, null: false
      t.integer :bath_count, null: false
      t.integer :square_feet
      t.integer :year_built
      t.integer :parking_spots

      t.integer :parking_type_id, null: false
      t.integer :zipcode_id, null: false
      t.integer :time_frame_id, null: false
    end

    add_foreign_key :property_cashflow_reports, :possession_types
    add_foreign_key :property_cashflow_reports, :properties
    add_foreign_key :property_cashflow_reports, :time_frames
    add_foreign_key :property_cashflow_reports, :comparison_groupings

    add_foreign_key :cashflow_items, :cashflow_types
    add_foreign_key :cashflow_items, :property_cashflow_reports

    add_foreign_key :cashflow_types, :time_frames

    add_foreign_key :comparison_groupings, :parking_types
    add_foreign_key :comparison_groupings, :zipcodes
  end
end
