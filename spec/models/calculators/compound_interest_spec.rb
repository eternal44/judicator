require 'rails_helper'

describe Calculators::CompoundInterest do
  it 'calculates compound interest return' do
    alternative_return_params = {
      :annual_interest_rate=>0.055,
      :compounding_periods_per_year=>24,
      :timeframe_in_years=>31,
      starting_principal: 20_000_00
    }

    comparision_return = described_class.initial_contribution(alternative_return_params)

    expect(comparision_return).to eq(10981329)
  end


  it 'calculates amount after a certain amount of time' do
    additional_contributions_params = {
      compounding_periods_per_year: 12,
      annual_interest_rate: 0.04,
      timeframe_in_years: 5,
      periodic_deposit: 100
    }

    comparision_return = described_class.continued_contributions(additional_contributions_params)

    expect(comparision_return).to eq(6_652_00)
  end

  it 'calculates an expected combined total' do
    additional_contributions_params = {
      compounding_periods_per_year: 12,
      annual_interest_rate: 0.04,
      timeframe_in_years: 5,
      periodic_deposit: 100
    }

    continued_contributions_return = described_class.continued_contributions(additional_contributions_params)

    alternative_return_params = {
      :annual_interest_rate=>0.04,
      :compounding_periods_per_year=>12,
      :timeframe_in_years=>5,
      starting_principal: 2_500_00
    }

    single_contribution_return = described_class.initial_contribution(alternative_return_params)

    expect(continued_contributions_return + single_contribution_return).to eq(970449)
  end
end
