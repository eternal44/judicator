require 'rails_helper'

describe Calculators::AmortizationSchedule do
  context 'with the correct inputs' do
    let(:starting_principal_balance) { 100_000_00.rationalize }
    let(:annual_interest_rate) { 0.045.rationalize }
    let(:scheduled_monthly_payment_amount) { 506_69.rationalize }

    let(:monthly_payment_params) do
      {
        starting_principal_balance: starting_principal_balance,
        annual_interest_rate: annual_interest_rate,
        scheduled_monthly_payment_amount: scheduled_monthly_payment_amount,
        opts: {}
      }
    end

    let(:schedule) do
      described_class.generate(monthly_payment_params)
    end

    it 'the principal and interest should equal the monthly payment' do
      mid_mark = schedule[180]
      expected_total = mid_mark[:principal_amount] + mid_mark[:interest_amount]

      expect(expected_total.to_i).to eq(scheduled_monthly_payment_amount.to_i)
    end

    it 'last payment should have 0 remaining balance' do
      expect(schedule.last[:principal_balance_amount]).to eq(0)
    end

    it 'should have 360 payments' do
      expect(schedule.count).to eq(360)
    end
  end
end

