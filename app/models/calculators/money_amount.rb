class Calculators::MoneyAmount < Calculators::CalculationAmount
  attr_reader :amount

  def initialize(amount, denomination: 'cents')
    super(amount)

    @amount = amount
    @denomination = denomination
  end

  def to_cents
    @amount * 100 if self.is_in_dollars?
  end

  def to_dollars
    @amount / 100 if self.is_in_cents?
  end

  def pretty_print
    # there's probably a Money class for this in rails
  end

  def is_in_cents?
    @denomination == 'cents'
  end

  def is_in_dollars?
    @denomination == 'dollars'
  end
end
