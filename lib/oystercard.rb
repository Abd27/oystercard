class Oystercard

  attr_reader :balance, :entry_station
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(value)
    fail "top up value can not be over #{MAX_BALANCE}" if value > MAX_BALANCE
    fail "max balance #{MAX_BALANCE} reached" if (@balance + value) > MAX_BALANCE
    

    @balance += value
  end
  
  
  def touch_in(entry_station)
    fail 'insufficient balance' if balance < MIN_FARE

    @entry_station = entry_station
  end
  
  def touch_out(exit_station)
    deduct(MIN_FARE)
    @entry_station = nil
  end

  def in_journey?
    !@entry_station.nil?
  end

  private
 
    def deduct(value)
    @balance -= value
    end

end
