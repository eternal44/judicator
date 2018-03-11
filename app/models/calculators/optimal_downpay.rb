class Calculators::OptimalDownpay
  attr_reader :no_additional_payments_schedule

  # NOTE: assume lender will allow bi-monthly payments
  def initialize(no_additional_payments_schedule,
                with_additional_payments_schedule)
    @no_additional_payments_schedule = no_additional_payments_schedule
    @with_additional_payments_schedule = with_additional_payments_schedule
  end
end

