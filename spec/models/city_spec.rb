require 'rails_helper'

# TODO: extract associations unrelated to cities to other specs
describe City do
  let!(:state) { Fabricate.create(:state, name: 'Foo') }
  let!(:state_2) { Fabricate.create(:state) }

  let!(:county) { Fabricate.create(:county, state: state, name: 'Bar') }
  let!(:county_2) { Fabricate.create(:county, state: state_2, name: 'Fee') }

  let!(:code) { '99999' }
  let!(:zipcode) { Fabricate.create(:zipcode, city: city, county: county, state: state, code: code) }

  let!(:city) { Fabricate.create(:city, state: state, county: county) }
  let!(:city_1) { Fabricate.create(:city, county: county) }

  context 'zipcode associations' do
    it 'are associated with the city' do
      zipcodes_in_city =
        Zipcode
          .where(city_id: city.id)
          .all
          .map(&:code)

      expect(zipcodes_in_city).to include(code)
    end
  end

  context 'county associations' do
    it 'contain related cities' do
      cities = county.cities
      associated_city_names = cities.map(&:name)

      expect(associated_city_names).to include(city.name)
      expect(cities.count).to eq(2)
    end

    it 'contain related zip codes' do
      associated_zipcodes =
        Zipcode
          .where(county_id: county.id)
          .all
          .map(&:code)

      expect(associated_zipcodes).to include(code)
    end

    it 'do not contain unrelated associations' do
    end
  end

  context 'state associations' do
    it 'contain related counties' do
      associated_counties =
        County.where(state_id: state.id)
        .all
        .map(&:name)

      expect(associated_counties).to include('Bar')
    end

    it 'contain related zipcodes' do
      associated_zipcodes =
        Zipcode
        .where(state_id: state.id)
        .all
        .map(&:code)

      expect(associated_zipcodes).to include(code)
    end

    it 'do not contain unrelated associations' do
      associated_counties =
        state_2.counties.all.map(&:name)

      expect(associated_counties).to_not include('Bar')
    end
  end
end
