class Calculators::OptimalDownpay
  # TODO: change signature to take a block?  Probably not - too much nesting
  def self.call(*params)
    new(params).call
  end

  def initialize(params)
    @additional_payments_params = params[0]
    @amortization_schedule_params = params[1]
  end

  def call
    @additional_payments_params.map { |additional_payment|
      merged_schedule_params = @amortization_schedule_params.merge(
        opts: {
          additional_payments: {
            start_period: 0,
            amount_per_period: additional_payment
          }
        }
      )

      schedule = Calculators::AmortizationSchedule.generate(merged_schedule_params)

      total_interest_paid = schedule
        .reduce(0) {|total, current_period|
          total += current_period[:interest_amount]
        }

      total_additional_payments = schedule.count * additional_payment

      {
        additional_payment: additional_payment,
        number_of_terms: schedule.count,
        total_interest_paid: total_interest_paid.to_i,
        total_additional_payments: total_additional_payments
      }
    }

  end
end
