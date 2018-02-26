class Calculators::CalculationAmount
  def initialize(*args)
    validate(args)
    format(args)
  end

  def format(args)
    args.map do |arg|
      arg.rationalize
    end
  end

  def validate(args)
    args.each do |arg|
      raise ArgumentError, 'non-rational number' unless arg.respond_to?(:rationalize)
      raise ArgumentError, 'negative number' unless arg.positive?
    end
  end
end
