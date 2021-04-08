class Oystercard

  attr_reader :balance, :entry_station
  MAX_BALANCE = 90
  MIN_BALANCE = 1

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
    fail 'insufficient balance' if balance < MIN_BALANCE

    @entry_station = entry_station
  end
  
  def touch_out(exit_station)
    deduct(1)
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
