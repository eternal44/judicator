Fabricator(:city) do
  name Faker::Address.city
  county
  state
end
