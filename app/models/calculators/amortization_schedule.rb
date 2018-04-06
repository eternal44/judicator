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

    @period_interest_rate = ((annual_interest_rate / 100)/ payments_per_year)
    @opts = opts
  end

  def generate
    generate_schedule([], @starting_principal_cents)
  end

  def generate_schedule(schedule, remaining_principal)
    period_payment_amount = @scheduled_period_payment_cents
    additional_payment_instructions = @opts.fetch(:additional_payments) do
      { start_period: -1,
        amount_per_period: 0 }
    end

    start_period, amount_per_period = additional_payment_instructions
      .values_at(:start_period,
                 :amount_per_period)

    if schedule.count >= start_period
      period_payment_amount += amount_per_period
    end

    interest_amount = remaining_principal * @period_interest_rate
    principal_amount = period_payment_amount - interest_amount
    new_remaining_principal = remaining_principal - principal_amount

    period_payment_object = generate_period_payment_object(
      remaining_principal: remaining_principal,
      period_interest_rate: @period_interest_rate,
      principal_amount: principal_amount,
      new_remaining_principal: new_remaining_principal,
      period_payment_amount: period_payment_amount,
      interest_amount: interest_amount
    )

    if (remaining_principal + interest_amount) <= period_payment_amount
      schedule << period_payment_object

      return schedule
    else
      schedule << period_payment_object

      generate_schedule(schedule, new_remaining_principal)
    end
  end

  def generate_period_payment_object(remaining_principal:,
                                     period_interest_rate:,
                                     principal_amount:,
                                     new_remaining_principal:,
                                     period_payment_amount:,
                                     interest_amount:)

    if (remaining_principal + interest_amount) <= period_payment_amount
      {
        total_payment_for_period: remaining_principal + interest_amount,
        principal_amount: remaining_principal,
        interest_amount: interest_amount,
        remaining_principal: 0
      }
    else
      {
        total_payment_for_period: period_payment_amount,
        principal_amount: principal_amount,
        interest_amount: interest_amount,
        remaining_principal: new_remaining_principal
      }
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
