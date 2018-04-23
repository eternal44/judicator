require 'rails_helper'

describe Calculators::CompoundInterest do
  context 'calculates compound interest' do
    it 'with no periodic deposits' do
      calc_params = {
        annual_interest_rate: 5.5,
        periods_per_year: 26,
        periodic_deposit: 0,
        starting_principal: 20_000_00,
        timeframe_in_years: 31,
      }

      comparision_return = described_class.calc(calc_params)

      expect(comparision_return).to eq(109_829_75)
    end

    it 'with no starting deposit' do
      calc_params = {
        annual_interest_rate: 4,
        periods_per_year: 12,
        periodic_deposit: 100_00,
        starting_principal: 0,
        timeframe_in_years: 5,
      }

      comparision_return = described_class.calc(calc_params)

      expect(comparision_return).to eq(6_629_90)
    end

    it 'with a starting & periodic deposit' do
      calc_params = {
        annual_interest_rate: 4,
        periods_per_year: 12,
        periodic_deposit: 100_00,
        starting_principal: 2_500_00,
        timeframe_in_years: 5,
      }

      result = described_class.calc(calc_params)

      expect(result).to eq(968239)
    end
  end
end
