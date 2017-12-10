class Calculators::CalculationAmount
  def initialize(*args)
    validate(args)
  end

  def validate(args)
    args.each do |arg|
      raise ArgumentError, 'non-rational number' unless arg.is_a?(Rational)
      raise ArgumentError, 'negative number' unless arg.positive?
    end
  end
end
