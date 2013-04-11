require 'helper'

describe Steffi::Graph do
  # subject { Steffi::Graph.famous 'meredith' }

  # its(:diameter) { should == 8   }
  # its(:vcount)   { should == 70  }
  # its(:ecount)   { should == 140 }

  # it 'can find communities' do
  #   subject.communities.should have(70).items
  # end

  # it 'errors gracefully' do
  #   expect { Steffi::Graph.famous 'non-existent' }.to raise_error(Steffi::Igraph::Error)
  # end

  it 'can create empty graphs' do
    g = Steffi::Graph.empty 5
    g.vertices.should have(5).members
    g.edges.should be_empty
  end

  it 'can create a graph with attributes' do
    pending
  end

  it 'can copy a graph' do
    g = Steffi::Graph.empty 7
    c = Steffi::Graph.copy g
    c.vertices.should have(7).members
  end

  it 'can destroy a graph' do
    # I don't see a great way to check that C memory has been freed
    Steffi::Graph.empty(1).should respond_to :destroy
  end
end