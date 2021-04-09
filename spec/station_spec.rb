require 'station'

describe Station do
  it{ is_expected.to be_instance_of(Station) }
  it{ expect(Station).to respond_to(:new).with(2).arguments}
  it{ expect(subject.name).to eq('Southfeilds') }
  it{ expect(subject.zone).to eq('1')}
end  