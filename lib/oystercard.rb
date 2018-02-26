class Oystercard
  attr_reader :balance
  BALANCE = 0

  def initialize(balance = BALANCE)
    @balance = balance
  end

  def top_up(added_money)
    @balance += added_money
  end

end
