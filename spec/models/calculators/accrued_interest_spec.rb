require 'rails_helper'

describe Calculators::AccruedInterest do
  context 'when the loan balance is positive' do
    let(:rate) { 0.034.rationalize }
    let(:loan_balance) { 100_000.rationalize }
    let(:params) do
      { rate: rate,
        loan_balance: loan_balance }
    end

    it 'returns correct amount' do
      expected_return = described_class.calculate(params)

      expect(expected_return).to eq(3400.rationalize)
    end
  end
end

