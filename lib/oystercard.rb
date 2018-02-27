class Oystercard
  attr_reader :balance, :card_status
  BALANCE = 0
  TOP_UP_LIMIT = 90
  ENTRY_LIMIT = 1

  def initialize(balance = BALANCE)
    @balance = balance
    @card_status = :not_in_use
  end

  def top_up(added_money)
    fail "Exceeded #{TOP_UP_LIMIT} limit" if (@balance + added_money) > TOP_UP_LIMIT
    @balance += added_money
  end

  def in_journey?
    @card_status == :in_use
  end

 def touch_in
     fail "Insufficient funds, top up." if check_limit
     @card_status = :in_use
 end

 def check_limit
   @balance < ENTRY_LIMIT
 end

 def touch_out
   @card_status = :not_in_use
   deduct(1)
 end

 private

 def deduct(deducted_money)
   @balance -= deducted_money
 end

end
