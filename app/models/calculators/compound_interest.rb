module Calculators::CompoundInterest
  # NOTE: referencing this site:
  #   https://www.thecalculatorsite.com/articles/finance/compound-interest-formula.php?page=2
  def self.calc(starting_principal:,
                periodic_deposit:,
                annual_interest_rate:,
                periods_per_year:,
                timeframe_in_years: )

    periodic_rate = annual_interest_rate / 100.0 / periods_per_year
    compounding_duration = periods_per_year * timeframe_in_years.to_f
    compound_effect = (1 + periodic_rate) ** compounding_duration

    starting_principal_result = (starting_principal * compound_effect)
    periodic_deposit_result = (periodic_deposit * (compound_effect - 1) / periodic_rate)

    (starting_principal_result + periodic_deposit_result).round
  end
end
