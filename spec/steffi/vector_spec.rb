require 'helper'

describe Steffi::Vector do
  subject do 
    v = Steffi::Vector.new
    v << 3.1415
    v << 1.6180
    v
  end

  its(:size) { should == 2 }

  it 'can read items' do
    subject[1].should == 1.6180
  end

  it 'can set items' do
    subject[0] = -1
    subject[0].should == -1
  end
end