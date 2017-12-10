# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171210174140) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cashflow_items", id: :serial, force: :cascade do |t|
    t.integer "amount", null: false
    t.integer "cashflow_type_id", null: false
    t.integer "report_id", null: false
  end

  create_table "cashflow_types", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.boolean "debit"
    t.boolean "credit"
    t.integer "time_frame_id", null: false
  end

  create_table "cities", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.integer "county_id", null: false
    t.integer "state_id", null: false
  end

  create_table "counties", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.float "property_tax_rate", null: false
    t.integer "state_id", null: false
  end

  create_table "parking_types", id: :serial, force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "possession_types", id: :serial, force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "properties", id: :serial, force: :cascade do |t|
    t.string "street_address", null: false
    t.integer "bedroom_count", null: false
    t.string "bathroom_count", null: false
    t.integer "structure_square_feet"
    t.integer "lot_square_feet"
    t.integer "year_constructed"
    t.integer "parking_spots"
    t.boolean "garage"
    t.string "longitude"
    t.string "latitude"
    t.integer "zipcode_id", null: false
    t.integer "property_classification_id", null: false
    t.integer "status_id", null: false
  end

  create_table "property_classifications", id: :serial, force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "report_groupings", id: :serial, force: :cascade do |t|
    t.integer "bed_count", null: false
    t.integer "bath_count", null: false
    t.integer "square_feet"
    t.integer "year_built"
    t.integer "parking_spots"
    t.integer "parking_type_id", null: false
    t.integer "zipcode_id", null: false
    t.integer "time_frame_id", null: false
  end

  create_table "reports", id: :serial, force: :cascade do |t|
    t.integer "list_price", null: false
    t.integer "days_on_market"
    t.boolean "is_short_sale"
    t.integer "property_id", null: false
    t.integer "time_frame_id", null: false
    t.integer "report_grouping_id", null: false
    t.integer "possession_type_id", null: false
  end

  create_table "states", id: :serial, force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "statuses", id: :serial, force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "time_frames", id: :serial, force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "zipcodes", id: :serial, force: :cascade do |t|
    t.string "code", null: false
    t.string "neighborhood_name"
    t.integer "city_id", null: false
    t.integer "county_id", null: false
    t.integer "state_id", null: false
  end

  add_foreign_key "cashflow_items", "cashflow_types"
  add_foreign_key "cashflow_items", "reports"
  add_foreign_key "cashflow_types", "time_frames"
  add_foreign_key "cities", "counties"
  add_foreign_key "cities", "states"
  add_foreign_key "counties", "states"
  add_foreign_key "properties", "property_classifications"
  add_foreign_key "properties", "statuses"
  add_foreign_key "properties", "zipcodes"
  add_foreign_key "report_groupings", "parking_types"
  add_foreign_key "report_groupings", "zipcodes"
  add_foreign_key "reports", "possession_types"
  add_foreign_key "reports", "properties"
  add_foreign_key "reports", "report_groupings"
  add_foreign_key "reports", "time_frames"
  add_foreign_key "zipcodes", "cities"
  add_foreign_key "zipcodes", "counties"
  add_foreign_key "zipcodes", "states"
end
