module Calculators::CompoundInterest
  # TODO: fix rate so it's a whole number

  def self.call(params)
    total = 0
    total += continued_contributions(params) unless params.fetch(:periodic_deposit).zero?
    total += initial_contribution(params) unless params.fetch(:starting_principal).zero?

    total
  end

  def self.initial_contribution(annual_interest_rate:,
                                periodic_deposit:,
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
                                   starting_principal:,
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
