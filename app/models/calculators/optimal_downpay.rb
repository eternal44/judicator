class Calculators::OptimalDownpay
  # TODO: use lazy evaluation 
  # TODO: change this so I can switch out the compound interest calc with whatever other
  #   alternative investment model I want
  # TODO: change function signature to take a hash instead
  # TODO: change @additional_payments_params to be a generic hash that takes instructions for:
  #   additional payments
  #   start_period
  #   starting down payment (for alternative calcs)
  def self.call(*params)
    new(params).call do |scenario_result|
      yield scenario_result if block_given?

      scenario_result
    end
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
      }.to_i

      total_additional_payments = schedule.count * additional_payment

      scenario_result = {
        additional_payment: additional_payment,
        number_of_terms: schedule.count,
        total_interest_paid: total_interest_paid,
        total_additional_payments: total_additional_payments
      }

      yield scenario_result if block_given?

      scenario_result
    }
  end
end
