class Oystercard
  attr_reader :card_status, :entry_station
  attr_accessor :balance


  BALANCE = 0
  TOP_UP_LIMIT = 90
  ENTRY_LIMIT = 1

  def initialize(balance = BALANCE)
    @balance = balance
    @entry_station = nil
  end

  def top_up(added_money)
    fail "Exceeded #{TOP_UP_LIMIT} limit" if (@balance + added_money) > TOP_UP_LIMIT
    @balance += added_money
  end

  def in_journey?
    @entry_station != nil
  end

 def touch_in(starting_station)
     fail "Insufficient funds, top up." if check_limit
     @entry_station = starting_station
 end

 def check_limit
   @balance < ENTRY_LIMIT
 end

 def touch_out
   @entry_station = nil
   deduct(1)
 end

 private

 def deduct(deducted_money)
   @balance -= deducted_money
 end

end
