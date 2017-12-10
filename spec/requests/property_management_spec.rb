require 'rails_helper'

RSpec.describe 'Properties API', type: :request do
  let!(:properties) do
    result = []

    10.times do
      property = Fabricate.create(:property)
      result.push(property)
    end

    result
  end
  let(:property_id) { properties.first.id }

  describe 'GET /properties/:id' do
    before do
      get "/properties/#{property_id}"
    end

    context 'when record exists' do
      it 'returns a property' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(property_id)
      end

      it 'returns status code 200' do
        expect(response.code).to eq('200')
      end
    end

    context 'when record does not exist' do
      let(:property_id) { 999 }

      it 'returns status code 404' do
        expect(response.body).to match(/Couldn't find Property/)
      end
    end

    context 'when request is malformed' do
      let(:property_id) { 'cat' }

      it 'returns status code 404' do
        expect(response.body).to match(/Couldn't find Property/)
      end
    end


    it 'returns all properties given parameters' do
    end

    it 'returns a "none found" message when not found' do
    end
  end
  context 'POST request' do
    it 'creates a Property' do
    end
  end

  context 'PUT request' do
    it 'edits property' do
    end
  end

  context 'DELETE request' do
    it 'deletes a Property' do
    end

    it 'deletes a list of properties' do
    end
  end

end
