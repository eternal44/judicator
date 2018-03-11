class Calculators::OptimalDownpay
  attr_reader :no_additional_payments_schedule

  # NOTE: assume lender will allow bi-monthly payments
  def initialize(schedule_a,
                schedule_b)
    @schedule_a = schedule_a
    @schedule_b = schedule_b
  end
end

