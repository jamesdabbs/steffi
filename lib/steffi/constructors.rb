module Steffi

  module Igraph
    bind :read_graph_edgelist, [:pointer, :pointer, :int, :bool], :int
    bind :atlas, [:pointer, :int], :int
    bind :cited_type_game, [:pointer, :int, :pointer, :pointer, :int, :bool], :int
    bind :erdos_renyi_game, [:pointer, :int, :int, :double, :bool, :bool], :int
    bind :forest_fire_game, [:pointer, :int, :double, :double, :int, :bool], :int
    bind :famous, [:pointer, :string], :int
    bind :full, [:pointer, :int, :bool, :bool], :int
    bind :ring, [:pointer, :int, :bool, :bool, :bool], :int
    bind :star, [:pointer, :int, :int, :int], :int
    bind :tree, [:pointer, :int, :int, :int], :int
  end

  class Graph

    constructor :load  do |path|
      C.open(path, 'r') do |stream|
        Igraph.read_graph_edgelist ptr, stream, 0, directed?
      end
    end

    constructor :atlas do |i|
      Igraph.atlas ptr, i
    end

    constructor :citations do |n, p|
      types = (0...n).to_a
      types = Vector.from_a(types).ptr
      prefs = [1.0 / p] * (n+1)
      prefs = Vector.from_a(prefs).ptr
      Igraph.cited_type_game ptr, n, types, prefs, 1, directed?
    end

    constructor :erdos_renyi do |n, k|
      Igraph.erdos_renyi_game ptr, 1, n, k, directed?, false
    end

    constructor :famous do |name|
      Igraph.famous ptr, name.to_s
    end

    constructor :forest_fire do |n, k|
      Igraph.forest_fire_game ptr, n, 0.01/k, 1, 2, directed?
    end

    constructor :full do |n|
      Igraph.full ptr, n, directed?, false
    end

    constructor :ring do |n|
      Igraph.ring ptr, n, directed?, false, true
    end

    constructor :star do |n|
      Igraph.star ptr, n, 2, 0
    end

    constructor :tree do |n, k|
      Igraph.tree ptr, n, k, 2
    end

  end
end