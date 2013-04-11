require 'helper'

describe 'Structure' do
  it 'can find subgraphs' do
    g  = Steffi::Graph.full 6
    sg = g.subgraph [0,1,2,4,5]
    sg.should have(10).edges
  end
end