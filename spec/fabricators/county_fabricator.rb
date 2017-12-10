Fabricator(:county) do
  name Faker::Address.community
  property_tax_rate 0.015
  state
end
