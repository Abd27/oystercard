require 'oystercard'

describe Oystercard do
  let(:max_balance)    { Oystercard::MAX_BALANCE }
  let(:entry_station)  { double :station }
    

    it "show a initial balance of zero" do
      expect(subject.balance).to eq(0)
    end

    it "enables you to top up by 5 pounds" do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end

    it "does not allow more than £90 to be topped up" do
      subject.top_up(max_balance)
      expect { subject.top_up(1) }.to raise_error "max balance #{max_balance} reached"
    end
   
    describe "touch in and out" do
      before do
        subject.top_up(max_balance)
      end

      it "returns a true value when card touches in" do
        subject.touch_in('station')
        expect(subject).to be_in_journey
      end

      it "returns a true value when card touches out" do
        subject.touch_in(entry_station)
        subject.touch_out
        expect(subject).not_to be_in_journey
      end

      it 'stores the entry station when touch in' do
        subject.touch_in(entry_station)
        expect(subject.entry_station).to eq(entry_station)
      end
      it 'deletes the entry station at touch out' do
        subject.touch_in(entry_station)
        subject.touch_out
        expect(subject.entry_station).to eq(nil)
      end
    end
    it 'refuses ride when less than minimum fare' do
      expect {subject.touch_in(entry_station)}.to raise_error('insufficient balance')
    end   
 
    it "does not allow a intial value over £90 to be topped up" do
      expect { subject.top_up(max_balance + 1) }.to raise_error "top up value can not be over #{max_balance}"
    end
    
    it "refuse ride when less than #{Oystercard::MIN_BALANCE}" do
      expect { subject.touch_in(entry_station) }.to raise_error('insufficient balance')
    end  
end
