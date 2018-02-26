class Oystercard
  attr_reader :balance
  BALANCE = 0
  LIMIT = 90

  def initialize(balance = BALANCE)
    @balance = balance
  end

  def top_up(added_money)
    fail "Balance limit #{LIMIT} exceeded" if (@balance + added_money) > LIMIT
    @balance += added_money
  end

  def deduct(deducted_money)
    @balance -= deducted_money
  end

end
