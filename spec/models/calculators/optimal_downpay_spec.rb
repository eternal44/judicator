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
        20_00,
        40_00,
      ]
    end

    it 'should create an array of objects with totals' do
      scenario_results = described_class.call(additional_payments_params,
                                              amortization_schedule_params)

      expect(scenario_results.first).to eq({:additional_payment => 2000,
                                            :number_of_terms => 547,
                                            :total_additional_payments => 1094000,
                                            :total_interest_paid => 5502668})


      expect(scenario_results.last).to eq({:additional_payment => 4000,
                                           :number_of_terms => 476,
                                           :total_additional_payments => 1904000,
                                           :total_interest_paid => 4689999})
    end

    xit 'example of how to use optimal downpay' do
      def money_format(cent_amount)
        Money.new(cent_amount).format
      end

      annual_interest_rate,
      periods_per_year = amortization_schedule_params
                                      .fetch_values(:annual_interest_rate,
                                                    :payments_per_year)

      scenario_results = described_class
        .call(additional_payments_params, amortization_schedule_params)
        .map do |scenario_result|
          timeframe_in_years = scenario_result.fetch(:number_of_terms).to_f / periods_per_year
          periodic_deposit = scenario_result.fetch(:additional_payment)

          alternative_investment_calculation_params = {
            annual_interest_rate: annual_interest_rate,
            periods_per_year: periods_per_year,
            periodic_deposit: periodic_deposit,
            starting_principal: 2_500_00,
            timeframe_in_years: timeframe_in_years,
          }

          scenario_result.fetch(:number_of_terms) / amortization_schedule_params.fetch(:payments_per_year).to_f

          alternative_result = Calculators::CompoundInterest
            .calc(alternative_investment_calculation_params)

          {
            loan_total_interest_paid: money_format(scenario_result.fetch(:total_interest_paid)),
            alternative_amount_gained: money_format(alternative_result),
            comparison_params: alternative_investment_calculation_params
          }
      end

      expect(scenario_results).to eq(true)
    end
  end
end
