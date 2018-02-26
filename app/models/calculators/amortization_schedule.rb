class Calculators::AmortizationSchedule < Calculators::CalculationAmount
  def self.generate(params)
    new(params).generate
  end

  def initialize(scheduled_period_payment_cents:,
                starting_principal_cents:,
                annual_interest_rate:,
                payments_per_year:,
                opts:)

    @scheduled_period_payment_cents,
    @starting_principal_cents,
    annual_interest_rate,
    payments_per_year = super(scheduled_period_payment_cents,
                              starting_principal_cents,
                              annual_interest_rate,
                              payments_per_year)

    @period_interest_rate = (annual_interest_rate / payments_per_year)
    @opts = opts
  end

  def generate
    generate_schedule([], @starting_principal_cents)
  end

  def generate_schedule(schedule, remaining_balance)
    period_payment_amount = @scheduled_period_payment_cents
    additional_payment_instructions = @opts[:additional_payments]

    if additional_payment_instructions &&
        schedule.count >= additional_payment_instructions[:start_period]

      period_payment_amount += additional_payment_instructions.fetch(:amount_per_period, 0)
    end

    interest_amount = remaining_balance * @period_interest_rate
    principal_amount = period_payment_amount - interest_amount
    principal_balance_amount = remaining_balance - principal_amount

    period_payment_object = {
      total_payment_for_period: period_payment_amount,
      principal_amount: principal_amount,
      interest_amount: interest_amount,
      principal_balance_amount: principal_balance_amount
    }

    if (remaining_balance) <= period_payment_amount
      final_period_payment_object = {
        total_payment_for_period: remaining_balance + interest_amount,
        principal_amount: remaining_balance,
        interest_amount: interest_amount,
        principal_balance_amount: 0
      }

      schedule << final_period_payment_object

      return schedule
    else
      schedule << period_payment_object

      generate_schedule(schedule, principal_balance_amount)
    end
  end

  def self.format_amounts(schedule, opts={})
    schedule.map do |period|
      period.each_with_object({}) do |period_attribute, memo|
        key, value = period_attribute
        memo[key] = value.to_i
      end
    end
  end
end
