module Calculators::CompoundInterest
  def self.call(params)
    total = 0
    total += continued_contributions(params) unless params.fetch(:periodic_deposit).zero?
    total += initial_contribution(params) unless params.fetch(:starting_principal).zero?

    total
  end

  # NOTE:  referencing this site:
  #    https://www.thecalculatorsite.com/articles/finance/compound-interest-formula.php
  def self.initial_contribution(annual_interest_rate:,
                                periodic_deposit:,
                                compounding_periods_per_year:,
                                timeframe_in_years:,
                                starting_principal:)

    (starting_principal *
      (1 + (annual_interest_rate / 100.0) / compounding_periods_per_year) **
      (compounding_periods_per_year * timeframe_in_years))
      .to_i
  end

  # NOTE: referencing this site:
  #   https://www.thecalculatorsite.com/articles/finance/compound-interest-formula.php?page=2
  def self.continued_contributions(compounding_periods_per_year:,
                                   annual_interest_rate:,
                                   timeframe_in_years:,
                                   starting_principal:,
                                   periodic_deposit:)

    periodic_interest_rate = (annual_interest_rate / 100.0) / compounding_periods_per_year
    number_of_compounding_periods = compounding_periods_per_year * timeframe_in_years

    total = periodic_deposit *
      (((1 + periodic_interest_rate) ** (number_of_compounding_periods) - 1) /
       periodic_interest_rate) *
      (1 + periodic_interest_rate)

    (total.round(2) * 100).to_i
  end

  def self.calc(starting_principal:,
                periodic_deposit:,
                annual_interest_rate:,
                compounding_periods_per_year:,
                timeframe_in_years: )

    # [ P(1+r/n)^(nt) ] + [ PMT × (((1 + r/n)^(nt) - 1) / (r/n)) ]

    periodic_rate = annual_interest_rate.to_f / compounding_periods_per_year
    compounding_duration = compounding_periods_per_year * timeframe_in_years.to_f

    starting_principal_result = (starting_principal * (1 + periodic_rate) ** compounding_duration)
    periodic_deposit_result = (periodic_deposit * (((1 + periodic_rate) ** compounding_duration) - 1) / periodic_rate)

    starting_principal_result + periodic_deposit_result
  end
end
