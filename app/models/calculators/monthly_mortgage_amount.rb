class Calculators::MonthlyMortgageAmount < Calculators::CalculationAmount
  def self.call(params)
    new(params).call
  end

  def initialize(annual_interest_rate:,
                starting_principal_cents:,
                terms_in_months:)

    super(annual_interest_rate, starting_principal_cents, terms_in_months)

    @annual_interest_rate = annual_interest_rate
    @starting_principal_cents = starting_principal_cents
    @terms_in_months = terms_in_months
    @monthly_interest_rate = self.calculate_monthly_interest_rate(annual_interest_rate)
  end

  def call
    numerator = calculate_numerator
    denominator = calculate_denominator

    @starting_principal_cents * (numerator / denominator)
  end

  def calculate_numerator
    @monthly_interest_rate * ((1 + @monthly_interest_rate) ** @terms_in_months)
  end

  def calculate_denominator
    ((1 + @monthly_interest_rate) ** @terms_in_months) - 1
  end

  def calculate_monthly_interest_rate(annual_interest_rate)
    (annual_interest_rate / 100) / 12
  end
end


