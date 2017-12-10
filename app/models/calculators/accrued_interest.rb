class Calculators::AccruedInterest < Calculators::CalculationAmount
  def self.calculate(params)
    new(params).calculate
  end

  def initialize(rate:,
                 loan_balance:)

    super(rate, loan_balance)

    @rate = rate
    @loan_balance = loan_balance
  end

  def calculate
    @loan_balance * @rate
  end
end
