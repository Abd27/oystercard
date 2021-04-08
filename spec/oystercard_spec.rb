require 'oystercard'

describe Oystercard do
  let(:max_balance)    { Oystercard::MAX_BALANCE }
  let(:entry_station)  { double :station }
  let(:exit_station)   { double :station }
    

    it "show a initial balance of zero" do
      expect(subject.balance).to eq(0)
    end
    
    describe "#top_up" do
      it "enables you to top up by 5 pounds" do
        subject.top_up(5)
        expect(subject.balance).to eq(5)
      end

      it "does not allow more than max balance to be topped up" do
        subject.top_up(max_balance)
        expect { subject.top_up(1) }.to raise_error "max balance #{max_balance} reached"
      end

      it "does not allow an initial top up of more then the max limit" do
        expect { subject.top_up(max_balance + 1) }.to raise_error "top up value can not be over #{max_balance}"
      end
    end  
   
    describe "touch in and out" do
      before do
        subject.top_up(max_balance)
      end

      it "lets the card be on journy once touched in" do
        subject.touch_in(entry_station)
        expect(subject).to be_in_journey
      end

      it 'in_journey should be false after touch_out' do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject).not_to be_in_journey
      end

      it 'stores the entry station when touch in' do
        subject.touch_in(entry_station)
        expect(subject.entry_station).to eq(entry_station)
      end
      it 'deletes the entry station at touch out' do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.entry_station).to eq(nil)
      end

      it { is_expected.to respond_to(:touch_out).with(1).argument }

      it 'deducts minimum fare from balance when journey is complete' do
        subject.touch_in(entry_station)
        expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by(-1)
      end

    end
    it 'refuses ride when less than minimum fare' do
      expect {subject.touch_in(entry_station)}.to raise_error('insufficient balance')
    end   
    
    it "refuse ride when less than minimum fare" do
      expect { subject.touch_in(entry_station) }.to raise_error('insufficient balance')
    end  
end
