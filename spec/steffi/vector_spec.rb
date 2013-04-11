require 'helper'

describe Steffi::Vector do
  it 'can be copied from an array' do
    v = Steffi::Vector.from_a [0, 1, 2]
    v.length.should == 3
  end

  # subject do 
  #   v = Steffi::Vector.new
  #   v << 3.1415
  #   v << 1.6180
  #   v
  # end

  # its(:size) { should == 2 }

  # it 'can read items' do
  #   subject[1].should == 1.6180
  # end

  # it 'can set items' do
  #   subject[0] = -1
  #   subject[0].should == -1
  # end
end