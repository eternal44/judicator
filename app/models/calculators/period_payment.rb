class Calculators::PeriodPayment < Calculators::CalculationAmount
  def self.call(params)
    new(params).call
  end

  def initialize(annual_interest_rate:,
                 starting_principal_cents:,
                 terms_in_months:,
                 periods_per_year:)

    @annual_interest_rate,
    @starting_principal_cents,
    @terms_in_months = super(annual_interest_rate,
                             starting_principal_cents,
                             terms_in_months)

    @period_interest_rate = self
      .period_interest_rate(annual_interest_rate, periods_per_year)
  end

  def call
    @starting_principal_cents * (numerator / denominator)
  end

  def numerator
    @period_interest_rate * ((1 + @period_interest_rate) ** @terms_in_months)
  end

  def denominator
    ((1 + @period_interest_rate) ** @terms_in_months) - 1
  end

  def period_interest_rate(annual_interest_rate, periods_per_year)
    (annual_interest_rate / 100) / periods_per_year
  end
end


