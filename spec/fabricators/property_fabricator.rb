Fabricator(:property) do
  street_address Faker::Address.street_address
  bedroom_count 2
  bathroom_count 2
  structure_square_feet 1_500
  lot_square_feet 2_000
  parking_spots 2
  garage true
  longitude Faker::Address.longitude
  latitude Faker::Address.latitude

  zipcode
  property_classification
  status
end
