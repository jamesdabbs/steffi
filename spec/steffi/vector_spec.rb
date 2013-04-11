require 'helper'

describe Steffi::Vector do
  it 'can create empty vectors' do
    Steffi::Vector.null.should be_empty
  end

  it 'can create vectors from slices' do
    Steffi::Vector.from_slice(5..9).should have(5).members
  end

  it 'errors on exclusive slices' do
    expect { Steffi::Vector.from_slice(5...9) }.to raise_error
  end

  # -----

  subject { Steffi::Vector.from_a [2, 3, 4] }

  its(:length)  { should == 3  }
  its(:sum)     { should == 9  }
  its(:product) { should == 24 }
  its(:tail)    { should == 4  }

  it 'can read values' do
    subject[1].should == 3
  end

  it 'can set and read values' do
    subject[1] = -1
    subject[1].should == -1
  end
end