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

  # -- 4.1-3 -----

  it 'can create empty graphs' do
    g = Steffi::Graph.empty 5
    g.vertices.should have(5).members
    g.edges.should be_empty
  end

  it 'can create a graph with attributes' do
    pending
  end

  it 'can create a directed graph' do
    g = Steffi::Graph.empty 5, true
    g.should be_directed
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

  it 'can create edges' do
    g = Steffi::Graph.empty 2
    g.edges << [0, 1]
    g.edges.should have(1).member
  end

  it 'can look up edges by id' do
    g = Steffi::Graph.full 5
    g.edges.first.should == [0, 1]
  end

  it 'can look up edges by vertex' do
    g = Steffi::Graph.full 5
    g.edges.find([0, 1]).should == 0
  end

  pending 'can lookup directed edges'
  pending 'can handle errors when looking up edges (eid, eids, eids_multi)'

  # it 'can look up a list of edges by vertex' do
  #   g = Steffi::Graph.full 3
  #   g.edges.find_pairs([0,1], [1,2]).should == [0, 1]
  # end

  # it 'can look up a list of edges in a path' do
  #   g = Steffi::Graph.full 3
  #   g.edges.find_path([0,1,2]).should == [0, 1]
  # end

  it 'can look up neighbors' do
    g = Steffi::Graph.full 5
    g.vertices.first.neighbors.should == [1, 2, 3, 4]
  end

  it 'knows incident edges' do
    g = Steffi::Graph.full 3
    g.vertices.first.incident.should == [0, 1]
  end
end