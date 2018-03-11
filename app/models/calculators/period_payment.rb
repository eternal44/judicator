class Calculators::PeriodPayment < Calculators::CalculationAmount
  def self.call(params)
    new(params).call
  end

  def initialize(annual_interest_rate:,
                 starting_principal_cents:,
                 loan_life_in_years:,
                 periods_per_year:)

    annual_interest_rate,
    periods_per_year,
    loan_life_in_years,
    @starting_principal_cents = super(annual_interest_rate,
                                      periods_per_year,
                                      loan_life_in_years,
                                      starting_principal_cents)

    @terms_in_periods = self
      .define_terms_in_periods(loan_life_in_years, periods_per_year)

    @period_interest_rate = self
      .define_period_interest_rate(annual_interest_rate, periods_per_year)
  end

  def call
    @starting_principal_cents * (numerator / denominator)
  end

  def numerator
    @period_interest_rate * ((1 + @period_interest_rate) ** @terms_in_periods)
  end

  def denominator
    ((1 + @period_interest_rate) ** @terms_in_periods) - 1
  end

  def define_terms_in_periods(loan_life_in_years, periods_per_year)
    loan_life_in_years * periods_per_year
  end

  def define_period_interest_rate(annual_interest_rate, periods_per_year)
    (annual_interest_rate / 100) / periods_per_year
  end
end


