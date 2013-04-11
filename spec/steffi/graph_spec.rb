require 'helper'

describe Steffi::Graph do
  # subject { Steffi::Graph.famous 'meredith' }

  # it 'can find communities' do
  #   subject.communities.should have(70).items
  # end

  # it 'errors gracefully' do
  #   expect { Steffi::Graph.famous 'non-existent' }.to raise_error(Steffi::Igraph::Error)
  # end

  # -- File handling -----

  # [:gml, :edgelist].each do |fmt|
  #   it "can dump and load .#{fmt}" do
  #     Steffi::Graph.star(8).dump f, fmt

  #     h = Steffi::Graph.load f, fmt
  #     h.should have(7).edges
  #   end
  # end

  # -- 4.1-3 -----

  it 'can create empty graphs' do
    g = Steffi::Graph.empty 5
    g.should have(5).vertices
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
    c.should have(7).vertices
  end

  it 'can destroy a graph' do
    # I don't see a great way to check that C memory has been freed
    Steffi::Graph.empty(1).should respond_to :destroy
  end

  it 'can create edges' do
    g = Steffi::Graph.empty 2
    g.edges << [0, 1]
    g.should have(1).edges
  end

  it 'can look up edges by id' do
    g = Steffi::Graph.full 5
    g.edges.first.to_pair.should == [0, 1]
  end

  it 'can look up edges by vertex' do
    g = Steffi::Graph.full 5
    g.edges.find([0, 1]).should == 0
  end

  pending 'can lookup directed edges'
  pending 'can handle errors when looking up edges (eid, eids, eids_multi)'

  it 'can look up a list of edges by vertex' do
    g = Steffi::Graph.full 3
    g.edges.find_pairs([0,1], [1,2]).should == [0, 2]
  end

  it 'can look up a list of edges in a path' do
    g = Steffi::Graph.full 3
    g.edges.find_path([0,1,2]).should == [0, 2]
  end

  it 'can look up neighbors' do
    g = Steffi::Graph.full 5
    g.vertices.first.neighbors.should == [1, 2, 3, 4]
  end

  it 'knows incident edges' do
    g = Steffi::Graph.full 3
    g.vertices.first.incident.should == [0, 1]
  end
end