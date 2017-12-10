Fabricator(:zipcode) do
  code Faker::Address.zip
  neighborhood_name Faker::Address.community
  city
  county
  state
end
