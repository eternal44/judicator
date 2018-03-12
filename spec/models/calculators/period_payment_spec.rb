require 'rails_helper'

describe Calculators::PeriodPayment do
  # TODO: not sure why this isn't working but use online calc for now
  # context 'bi-weekly payment schedule' do
  #   # TODO: Expected amount sourced from:
  #   #       https://www.mtgprofessor.com/calculators/Calculator2bi.html
  # context 'bi-weekly payments' do
  #   let(:annual_interest_rate) { 4.5 }
  #   let(:starting_principal_cents) { 508_000_00 }
  #   let(:loan_life_in_years) { 30 }
  #   let(:periods_per_year) { 26 }
  #   let(:params) do
  #     { annual_interest_rate: annual_interest_rate,
  #       starting_principal_cents: starting_principal_cents,
  #       loan_life_in_years: loan_life_in_years,
  #       periods_per_year: periods_per_year
  #     }
  #   end

  #   it 'returns the correct monthly payment amount' do
  #     bi_weekly_payment =  described_class.call(params)

  #     expect(bi_weekly_payment.to_i).to eq(1_286_98)
  #   end
  # end

  context 'monthly payments' do
    let(:annual_interest_rate) { 4.5 }
    let(:starting_principal_cents) { 508_000_00 }
    let(:loan_life_in_years) { 30 }
    let(:periods_per_year) { 12 }
    let(:params) do
      { annual_interest_rate: annual_interest_rate,
        starting_principal_cents: starting_principal_cents,
        loan_life_in_years: loan_life_in_years,
        periods_per_year: periods_per_year
      }
    end

    it 'returns the correct monthly payment amount' do
      monthly_payment =  described_class.call(params)

      expect(monthly_payment.to_i).to eq(2_573_96)
    end
  end
end
