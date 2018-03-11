require 'rails_helper'

def format_money(cent_amount)
  Money.new(cent_amount).format
end

describe Calculators::OptimalDownpay do
  let(:starting_principal_cents) { 80_000_00 }
  let(:annual_interest_rate) { 0.055 }
  let(:scheduled_period_payment_cents) { 454_23 }
  let(:start_period) { 1 }
  let(:additional_amount_per_period) { 2_800_00 }

  let(:opts) do
    {
      additional_payments: {
        start_period: start_period,
        amount_per_period: additional_amount_per_period
      }
    }
  end

  let(:additional_payments_params) do
    {
      starting_principal_cents: starting_principal_cents,
      annual_interest_rate: annual_interest_rate,
      scheduled_period_payment_cents: scheduled_period_payment_cents,
      payments_per_year: 12,
      opts: opts
    }
  end

  let(:no_additional_payments_params) do
    {
      starting_principal_cents: starting_principal_cents,
      annual_interest_rate: annual_interest_rate,
      scheduled_period_payment_cents: scheduled_period_payment_cents,
      payments_per_year: 12,
      opts: {}
    }
  end

  let(:no_additional_payments_schedule) do
    amortization_schedule = Calculators::AmortizationSchedule
      .generate(no_additional_payments_params)
  end

  let(:with_additional_payments_schedule) do
    amortization_schedule = Calculators::AmortizationSchedule
      .generate(additional_payments_params)
  end

  context 'payment frequency: ' do
    let(:monthly_payment_params) do
      {
        starting_principal_cents: starting_principal_cents,
        annual_interest_rate: annual_interest_rate,
        scheduled_period_payment_cents: scheduled_period_payment_cents,
        payments_per_year: 12,
        opts: {}
      }
    end

    let(:bi_monthly_payment_params) do
      {
        starting_principal_cents: starting_principal_cents,
        annual_interest_rate: annual_interest_rate,
        scheduled_period_payment_cents: scheduled_period_payment_cents / 2,
        payments_per_year: 24,
        opts: {}
      }
    end

    let(:monthly_payment_schedule) do
      amortization_schedule = Calculators::AmortizationSchedule
        .generate(monthly_payment_params)
    end

    let(:bi_monthly_payment_schedule) do
      amortization_schedule = Calculators::AmortizationSchedule
        .generate(bi_monthly_payment_params)
    end

    it 'bi-weekly payments should be half of monthly payments' do
       = described_class
        .new(monthly, with_additional_payments_schedule)
        .no_additional_payments_schedule
        .first

    end

    it 'bi-weekly payments should end sooner than monthly payments' do
    end

    it 'calculates schedule as expected' do
      period = described_class
        .new(no_additional_payments_schedule, with_additional_payments_schedule)
        .no_additional_payments_schedule
        .first

      expected_period = {
        :interest_amount => (110000/3.to_r),
        :principal_amount => (26269/3.to_r),
        :principal_balance_amount => (23973731/3.to_r),
        :total_payment_for_period => (45423/1.to_r)
      }

      expect(period).to eq(expected_period)

      period.values.each do |value|
        expect(value.class).to eq(Rational)
      end
    end
  end
end
