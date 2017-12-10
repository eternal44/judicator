require 'rails_helper'

describe Calculators::MoneyAmount do
  context 'valid amounts' do
    let(:amount) { 100.rationalize }

    it 'converts a cent amount to dollars' do
      expected_amount = described_class.new(amount).to_dollars

      expect(expected_amount).to eq(1.rationalize)
    end

    it 'converts a dollar amount to cents' do
      expected_amount = described_class.new(amount, denomination: 'dollars').to_cents

      expect(expected_amount).to eq(10_000.rationalize)
    end

    it '#amount returns returns the amount attribute' do
      expected_amount = described_class.new(amount, denomination: 'dollars').amount

      expect(expected_amount).to eq(100.rationalize)
    end
  end
end

