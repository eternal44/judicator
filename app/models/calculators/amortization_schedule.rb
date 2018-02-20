class Calculators::AmortizationSchedule
  def self.generate(params)
    new(params).generate
  end

  def initialize(scheduled_monthly_payment_amount:,
                starting_principal_balance:,
                annual_interest_rate:,
                opts:)
    @scheduled_monthly_payment_amount = scheduled_monthly_payment_amount
    @monthly_interest_rate = (annual_interest_rate / 12)
    @opts = opts
    @starting_principal_balance = starting_principal_balance
  end

  def generate
    generate_schedule([], @starting_principal_balance)
  end

  def generate_schedule(schedule, remaining_balance)
    if remaining_balance < 1
      schedule
    else
      monthly_payment = generate_monthly_payment(remaining_balance)

      schedule << monthly_payment

      new_balance = remaining_balance - monthly_payment[:principal_amount]

      generate_schedule(schedule, new_balance)
    end
  end

  private

  def generate_monthly_payment(remaining_balance)
    interest_amount = calculate_interest_amount(remaining_balance)
    principal_amount = calculate_principal_amount(remaining_balance, interest_amount)
    principal_balance_amount = remaining_balance - principal_amount

    {
      total_payment_for_month: @scheduled_monthly_payment_amount,
      principal_amount: principal_amount,
      interest_amount: interest_amount,
      principal_balance_amount: principal_balance_amount
    }
  end

  def calculate_interest_amount(remaining_balance)
    remaining_balance * @monthly_interest_rate
  end

  def calculate_principal_amount(remaining_balance, interest_amount, opts={})
    additional_payment = opts.fetch(:additional_payment, 0)

    monthly_payment = @scheduled_monthly_payment_amount + additional_payment
    if remaining_balance < @scheduled_monthly_payment_amount
      remaining_balance
    else
      @scheduled_monthly_payment_amount - interest_amount
    end
  end
end
