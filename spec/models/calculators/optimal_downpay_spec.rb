require 'rails_helper'

describe Calculators::OptimalDownpay do
  context 'bi-weekly payment period with additional payment scenarios' do
    let(:starting_principal_cents) { 80_000_00 }
    let(:annual_interest_rate) { 5.5 }
    let(:scheduled_period_payment_cents) {
      (Calculators::PeriodPayment.call({
        annual_interest_rate: annual_interest_rate,
        starting_principal_cents: starting_principal_cents,
        loan_life_in_years: 30,
        periods_per_year: 12
      }) / 2).to_i
    }

    let(:start_period) { 1 }
    let(:additional_amount_per_period) { 2_800_00 }
    let(:amortization_schedule_params) do
      {
        starting_principal_cents: starting_principal_cents,
        annual_interest_rate: annual_interest_rate,
        scheduled_period_payment_cents: scheduled_period_payment_cents,
        payments_per_year: 26,
        opts: {
          additional_payments: {
            start_period: start_period,
            amount_per_period: additional_amount_per_period
          }
        }
      }
    end

    let(:additional_payments_params) do
      [
        0,
        100_00,
        200_00,
        300_00,
        400_00,
        500_00,
        600_00,
        700_00,
        800_00,
        900_00,
        1_000_00,
      ]
    end

    it 'should create an array of objects with totals' do
      scenario_results = described_class.call(additional_payments_params,
                                              amortization_schedule_params)

      expect(scenario_results.first).to eq({:additional_payment=>0,
                                            :number_of_terms=>647,
                                            :total_interest_paid=>6692595,
                                            :total_additional_payments=>0})

      expect(scenario_results.last).to eq({:additional_payment=>100000,
                                            :number_of_terms=>71,
                                            :total_interest_paid=>617382,
                                            :total_additional_payments=>7100000})
    end

    it 'takes a block that can access each scenario' do
      scenario_results = described_class
        .call(additional_payments_params, amortization_schedule_params)
        .map do |scenario_result|
          {
            scenario_result: scenario_result,
            comparison_result: "foo" # TODO: refactor compound_interest module first
          }
        end
    end
  end
end
