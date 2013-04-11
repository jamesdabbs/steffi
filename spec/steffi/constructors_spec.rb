require 'helper'

describe 'Graph constructors' do
  def self.constructor name, *args, &block
    it "- #{name}" do
      instance_exec Steffi::Graph.send(name, *args), &block
    end
  end

  constructor :atlas, 1 do |graph|
    graph.should have(1).vertices
  end

  constructor :citations, 55 do |graph|
    graph.should have(55).vertices
  end

  constructor :erdos_renyi, 100, 123 do |graph|
    graph.should have(123).edges
  end

  constructor :famous, 'meredith' do |graph|
    graph.should have(70).vertices
  end

  constructor :forest_fire, 111, 0.01, 3, 20 do |graph|
    graph.should have(111).vertices
  end

  constructor :full, 4 do |graph|
    graph.should have(6).edges
  end

  constructor :ring, 9 do |graph|
    graph.should have(9).edges
  end

  constructor :star, 6 do |graph|
    graph.should have(5).edges
  end

  constructor :tree, 16, 2 do |graph|
    graph.should have(15).edges
  end
end