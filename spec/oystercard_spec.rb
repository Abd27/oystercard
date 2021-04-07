require 'oystercard'

describe Oystercard do
  let(:max_balance) { Oystercard::MAX_BALANCE }
    
    it { is_expected.to be_an_instance_of Oystercard }

    it "can show a balance" do
      expect(subject).to respond_to(:balance)
    end

    it { expect(subject).to respond_to(:top_up).with(1).argument }

    it "enables you to top up by 5 pounds" do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end

    it "does not allow more than £90 to be topped up" do
      subject.top_up(max_balance)
      expect { subject.top_up(1) }.to raise_error "max balance #{max_balance} reached"
    end

    it {is_expected.to respond_to(:deduct).with(1).argument }

    it "deducts 10 pounds" do
      subject.top_up(max_balance)
      subject.deduct(10)
      expect(subject.balance).to eq(80)
    end  

    it { is_expected.to respond_to(:touch_in) }
   
    describe "touch in and out" do
      before do
        subject.top_up(max_balance)
      end

      it "returns a true value when card touches in" do
        subject.touch_in
        expect(subject).to be_in_journey
      end

      it { is_expected.to respond_to(:touch_out) }

      it "returns a true value when card touches out" do
        subject.touch_in
        subject.touch_out
        expect(subject).not_to be_in_journey
      end
    end  
 
    it "does not allow a intial value over £90 to be topped up" do
      expect { subject.top_up(max_balance + 1) }.to raise_error "top up value can not be over #{max_balance}"
    end
    
    it "refuse ride when less than #{Oystercard::MIN_BALANCE}" do
      expect { subject.touch_in }.to raise_error("insufficent balance")
    end  
end
