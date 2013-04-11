require 'helper'

describe 'Graph constructors' do
  def self.constructor name, *args
    it "- #{name}" do
      # FIXME: why is `should have(n).vertices` syntax not working here?
      yield Steffi::Graph.send name, *args
    end
  end

  constructor :atlas, 1 do |graph|
    graph.vertices.size.should == 1
  end

  constructor :famous, 'meredith' do |graph|
    graph.vertices.size.should == 70
  end

  constructor :full, 4 do |graph|
    graph.edges.size.should == 6
  end

  constructor :ring, 9 do |graph|
    graph.edges.size.should == 9
  end

  constructor :star, 6 do |graph|
    graph.edges.size.should == 5
  end

  constructor :tree, 16, 2 do |graph|
    graph.edges.size.should == 15
  end
end