module Calculators::CompoundInterest
  def self.initial_contribution(annual_interest_rate:,
                                compounding_periods_per_year:,
                                timeframe_in_years:,
                                starting_principal:)

    (starting_principal *
     (1 + annual_interest_rate / compounding_periods_per_year) **
     (compounding_periods_per_year * timeframe_in_years))
      .to_i
  end

  def self.continued_contributions(compounding_periods_per_year:,
                                   annual_interest_rate:,
                                   timeframe_in_years:,
                                   periodic_deposit:)
    periodic_interest_rate = annual_interest_rate / compounding_periods_per_year
    number_of_compounding_periods = compounding_periods_per_year * timeframe_in_years

    total = periodic_deposit *
      (((1 + periodic_interest_rate) ** (number_of_compounding_periods) - 1) /
       periodic_interest_rate) *
      (1 + periodic_interest_rate)

    (total.round(2) * 100).to_i
  end
end
