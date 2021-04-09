require_relative 'station'

class Oystercard

  attr_reader :balance, :entry_station, :exit_station, :journey_list
  MAX_BALANCE = 90
  MIN_FARE = 1

  def initialize
    @balance = 0
    @journey_list = []
  end

  def top_up(value)
    fail "max balance #{MAX_BALANCE} reached" if balance_exceeded?(value)
    

    @balance += value
  end
  
  
  def touch_in(entry_station)
    fail 'insufficient balance' if balance < MIN_FARE

    @entry_station = entry_station
  end
  
  def touch_out(exit_station)
    save_journey(entry_station, exit_station)
    deduct(MIN_FARE)
    @exit_station = exit_station
    @entry_station = nil
  end

  def in_journey?
    !@entry_station.nil?
  end

  def save_journey(entry_station, exit_station)
    @journey_list << { :entry => entry_station, :exit => exit_station }
  end

  private
 
    def deduct(value)
    @balance -= value
    end

    def balance_exceeded?(value)
      @balance + value > MAX_BALANCE
    end  

end
