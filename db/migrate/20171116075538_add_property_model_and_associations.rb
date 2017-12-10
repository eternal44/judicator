class AddPropertyModelAndAssociations < ActiveRecord::Migration

  def change
    create_table :properties do |t|
      t.string :street_address, null: false
      t.integer :bedroom_count, null: false
      t.string :bathroom_count, null: false
      t.integer :structure_square_feet
      t.integer :lot_square_feet
      t.integer :year_constructed
      t.integer :parking_spots
      t.boolean :garage
      t.string :longitude
      t.string :latitude

      t.integer :zipcode_id, null: false
      t.integer :property_classification_id, null: false
      t.integer :status_id, null: false
    end

    # TODO: a city, county, and state can contain multiple zip codes.  think this association thru
    create_table :zipcodes do |t|
      t.string :code, null: false
      t.string :neighborhood_name

      t.integer :city_id, null: false
      t.integer :county_id, null: false
      t.integer :state_id, null: false
    end

    create_table :cities do |t|
      t.string :name, null: false

      t.integer :county_id, null: false
      t.integer :state_id, null: false
    end

    create_table :counties do |t|
      t.string :name, null: false
      t.float :property_tax_rate, null: false

      t.integer :state_id, null: false
    end

    create_table :states do |t|
      t.string :name, null: false
    end

    create_table :property_classifications do |t|
      t.string :name, null: false
    end

    create_table :statuses do |t|
      t.string :name, null: false
    end

    add_foreign_key :properties, :zipcodes
    add_foreign_key :properties, :property_classifications
    add_foreign_key :properties, :statuses

    add_foreign_key :zipcodes, :cities
    add_foreign_key :zipcodes, :counties
    add_foreign_key :zipcodes, :states

    add_foreign_key :cities, :counties
    add_foreign_key :cities, :states

    add_foreign_key :counties, :states
  end
end
