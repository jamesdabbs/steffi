require 'helper'

describe Steffi::Graph do
  subject { Steffi::Graph.famous 'meredith' }

  its(:diameter) { should == 8   }
  its(:vcount)   { should == 70  }
  its(:ecount)   { should == 140 }

  it 'can find communities' do
    subject.community.should have(70).items
  end

  it 'errors gracefully' do
    expect { Steffi::Graph.famous 'non-existent' }.to raise_error(Steffi::Igraph::Error)
  end
end