require 'rails_helper'

describe Calculators::AmortizationSchedule do
  let(:starting_principal_cents) { 80_000_00.rationalize }
  let(:annual_interest_rate) { 0.055.rationalize }
  let(:scheduled_period_payment_cents) { 454_23.rationalize }

  context 'with the correct inputs' do

    let(:period_payment_params) do
      {
        starting_principal_cents: starting_principal_cents,
        annual_interest_rate: annual_interest_rate,
        scheduled_period_payment_cents: scheduled_period_payment_cents,
        opts: {}
      }
    end

    let(:schedule) do
      described_class.generate(period_payment_params)
    end

    it 'the principal and interest should equal the period payment' do
      mid_mark = schedule[180]
      expected_total = mid_mark[:principal_amount] + mid_mark[:interest_amount]

      expect(expected_total.to_i).to eq(scheduled_period_payment_cents.to_i)
    end

    it 'last payment should have 0 remaining balance' do
      expect(schedule.last[:principal_balance_amount]).to eq(0)
    end

    it 'should have 360 payments' do
      expect(schedule.count).to eq(360)
    end
  end

  context 'options params' do
    let(:starting_principal_cents) { 80_000_00.rationalize }
    let(:annual_interest_rate) { 0.055.rationalize }
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

    let(:period_payment_params) do
      {
        starting_principal_cents: starting_principal_cents,
        annual_interest_rate: annual_interest_rate,
        scheduled_period_payment_cents: scheduled_period_payment_cents,
        opts: opts
      }
    end

    let(:schedule) do
      described_class.generate(period_payment_params)
    end

    context 'additional payments' do
      let(:additional_amount_per_period) { 2_800_00 }
      let(:period_payment_params) do
        {
          starting_principal_cents: starting_principal_cents,
          annual_interest_rate: annual_interest_rate,
          scheduled_period_payment_cents: scheduled_period_payment_cents,
          opts: {
            additional_payments: {
              start_period: start_period,
              amount_per_period: additional_amount_per_period
            }
          }
        }
      end

      let(:schedule) { described_class.generate(period_payment_params) }

      context 'from the middle of the schedule' do
        let(:start_period) { 10 }

        it 'returns the right number of payments' do
          expect(schedule.count).to eq(36)
        end

        it 'total payments paid is correct' do
          total_paid = schedule
            .map{ |p|
              p[:total_payment_for_period]
            }
            .reduce(&:+)
            .to_i

          expect(total_paid).to eq(8860563)
        end

        it 'last payment should be remaining balance' do
          expect(schedule.last[:total_payment_for_period].to_i).to eq(270758)
        end
      end

      context 'from the start of the schedule' do
        let(:start_period) { 0 }

        it 'returns the right number of payments' do
          expect(schedule.count).to eq(27)
        end

        it 'total payments paid is correct' do
          total_paid = schedule
            .map{ |p|
              p[:total_payment_for_period]
            }
            .reduce(&:+)
            .to_i

          expect(total_paid).to eq(8507222)
        end

        it 'last payment should be remaining balance' do
          expect(schedule.last[:total_payment_for_period].to_i).to eq(46224)
        end
      end
    end

    context 'format amounts' do
      it 'formats to integers' do
        described_class
          .format_amounts(schedule)
          .last
          .values
          .each do |amount|
            expect(amount.class).to eq(Integer)
          end
      end
    end
  end
end

