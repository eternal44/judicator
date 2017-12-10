require 'rails_helper'

describe Property do
  let!(:state_1) { Fabricate.create(:state) }
  let!(:state_2) { Fabricate.create(:state, name: 'Arizona') }

  let(:county_1) { Fabricate.create(:county, state: state_1) }
  let(:county_2) { Fabricate.create(:county, state: state_2) }

  let(:city_1) { Fabricate.create(:city, state: state_1, county: county_1) }
  let(:city_2) { Fabricate.create(:city, state: state_2, county: county_2) }

  let(:zipcode_1) { Fabricate.create(:zipcode, city: city_1, county: county_1, state: state_1) }
  let(:zipcode_2) { Fabricate.create(:zipcode, city: city_2, county: county_2, state: state_2) }

  let(:property_classification_1) { Fabricate.create(:property_classification) }
  let(:property_classification_2) { Fabricate.create(:property_classification, name: 'condo') }

  let(:status_1) { Fabricate.create(:status) }
  let(:status_2) { Fabricate.create(:status, name: 'short sale') }

  let!(:property_1) { Fabricate.create(:property,
                                       street_address: 'Foo St',
                                       zipcode: zipcode_1,
                                       property_classification: property_classification_1,
                                       status: status_1) }

  let!(:property_2) { Fabricate.create(:property,
                                       street_address: 'Bar St',
                                       zipcode: zipcode_2,
                                       property_classification: property_classification_2,
                                       status: status_2) }


  before do
    expect(Property.count).to eq(2)
  end

  context 'zipcode associations' do
    let(:associated_properties) { zipcode_1.properties.map(&:street_address) }

    it 'return all associated properties' do
      expect(associated_properties).to include('Foo St')
    end

    it 'do not return unassociated properties' do
      expect(associated_properties).to_not include('Bar St')
    end
  end

  context 'status associations' do
    let(:associated_properties) { status_1.properties.map(&:street_address) }

    it 'are returned when queried' do
      expect(associated_properties).to include('Foo St')
    end

    it 'do not return unassociated properties' do
      expect(associated_properties).to_not include('Bar St')
    end
  end

  context 'property classification associations' do
    let(:associated_properties) { property_classification_1.properties.map(&:street_address) }

    it 'are returned when queried' do
      expect(associated_properties).to include('Foo St')
    end

    it 'do not return unassociated properties' do
      expect(associated_properties).to_not include('Bar St')
    end
  end
end
