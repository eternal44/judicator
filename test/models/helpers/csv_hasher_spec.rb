require 'rails_helper'

describe Helpers::CsvHasher do
  let(:file_path) do
    Rails.root + 'spec/models/helpers/example_redfin_favorites.csv'
  end

  let(:attributes_of_properties) { described_class.call(file_path) }

  let(:attributes_of_one_property) { attributes_of_properties.first }

  let(:expected_attributes_keys) do
    ["SALE TYPE",
     "HOME TYPE",
     "ADDRESS",
     "CITY",
     "STATE",
     "ZIP",
     "LIST PRICE",
     "BEDS",
     "BATHS",
     "LOCATION",
     "SQFT",
     "LOT SIZE",
     "YEAR BUILT",
     "PARKING SPOTS",
     "PARKING TYPE",
     "DAYS ON MARKET",
     "STATUS",
     "NEXT OPEN HOUSE DATE",
     "NEXT OPEN HOUSE START TIME",
     "NEXT OPEN HOUSE END TIME",
     "RECENT REDUCTION DATE",
     "ORIGINAL LIST PRICE",
     "LAST SALE DATE",
     "LAST SALE PRICE",
     "URL (SEE http://www.redfin.com/buy-a-home/comparative-market-analysis FOR INFO ON PRICING)",
     "SOURCE",
     "LISTING ID",
     "ORIGINAL SOURCE",
     "FAVORITE",
     "INTERESTED",
     "LATITUDE",
     "LONGITUDE",
     "IS SHORT SALE"]
  end

  it 'is an array' do
    expect(attributes_of_properties.is_a?(Array)).to eq(true)
  end

  it 'items are a hash' do
    expect(attributes_of_one_property.is_a?(Hash)).to eq(true)
  end

  it 'should have the correct keys' do
    expect(attributes_of_one_property.keys).to eq(expected_attributes_keys)
  end

end
