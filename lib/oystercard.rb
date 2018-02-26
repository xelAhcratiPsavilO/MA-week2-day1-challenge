class Oystercard
  attr_reader :balance
  BALANCE = 0
  LIMIT = 90

  def initialize(balance = BALANCE)
    @balance = balance
    @card_status = :not_in_use
  end

  def top_up(added_money)
    fail "Balance limit #{LIMIT} exceeded" if (@balance + added_money) > LIMIT
    @balance += added_money
  end

  def deduct(deducted_money)
    @balance -= deducted_money
  end

  def in_journey?
    @card_status == :in_use
  end

 def touch_in
     @card_status = :in_use
 end

 def touch_out
   @card_status = :not_in_use
 end

end
