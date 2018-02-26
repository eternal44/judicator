require 'rails_helper'

describe Calculators::MonthlyMortgageAmount do
  let(:annual_interest_rate) { 4.5 }
  let(:starting_principal_cents) { 508_000_00 }
  let(:terms_in_months) { 360 }
  let(:params) do
    { annual_interest_rate: annual_interest_rate,
      starting_principal_cents: starting_principal_cents,
      terms_in_months: terms_in_months
    }
  end

  it 'returns the correct monthly payment amount' do
    monthly_payment =  described_class.call(params)

    expect(monthly_payment.to_i).to eq(2_573_96)
  end
end
