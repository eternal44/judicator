require 'rails_helper'

describe Calculators::CompoundInterest do
  context 'calculates compound interest' do
    it 'with no periodic deposits' do
      calc_params = {
        annual_interest_rate: 0.055,
        compounding_periods_per_year: 24,
        periodic_deposit: 0,
        starting_principal: 20_000_00,
        timeframe_in_years: 31,
      }

      comparision_return = described_class.call(calc_params)

      expect(comparision_return).to eq(10981329)
    end


    it 'with no starting deposit' do
      calc_params = {
        annual_interest_rate: 0.04,
        compounding_periods_per_year: 12,
        periodic_deposit: 100,
        starting_principal: 0,
        timeframe_in_years: 5,
      }

      comparision_return = described_class.call(calc_params)

      expect(comparision_return).to eq(6_652_00)
    end

    it 'with a starting & periodic deposit' do
      calc_params = {
        annual_interest_rate: 0.04,
        compounding_periods_per_year: 12,
        periodic_deposit: 100,
        starting_principal: 2_500_00,
        timeframe_in_years: 5,
      }

      result = described_class.call(calc_params)

      expect(result).to eq(970449)
    end
  end
end
