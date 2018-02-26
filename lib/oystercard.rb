class Oystercard
  attr_reader :balance
  BALANCE = 0

  def initialize(balance = BALANCE)
    @balance = balance
  end

end
