class Oystercard
  attr_reader :card_status, :entry_station, :exit_station
  attr_accessor :balance, :history

  BALANCE = 0
  TOP_UP_LIMIT = 90
  ENTRY_LIMIT = 1

  def initialize(balance = BALANCE)
    @balance = balance
    @entry_station = nil
    @exit_station = nil
    @history = []
  end

  def top_up(value)
    raise "Exceeded top up limit of: #{TOP_UP_LIMIT}" if (@balance + value) > TOP_UP_LIMIT
    @balance += value
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(starting_station)
    raise 'Insufficient funds, top up.' if check_limit
    @entry_station = starting_station
  end

  def check_limit
    @balance < ENTRY_LIMIT
  end

  def touch_out(exit_station)
    @exit_station = exit_station
    @history << { entry_station: @entry_station, exit_station: @exit_station }
    @entry_station = nil
    deduct(ENTRY_LIMIT)
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
