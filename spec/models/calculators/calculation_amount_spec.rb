require 'rails_helper'

describe Calculators::CalculationAmount do
  context 'non-rational amounts' do
    let(:amount) { 100 }

    it 'raise an argument error' do
      expect{ described_class.new(amount).validate }.to raise_error(ArgumentError)
    end
  end

  context 'negative amounts' do
    let(:rate) {-0.3}
    let(:loan_balance) {-100_000.rationalize}

    it 'throws an error' do
      expect{ described_class.new(rate, loan_balance).validate }.to raise_error(ArgumentError)
    end
  end
end
