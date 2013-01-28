module Steffi
  bind :atlas, [:pointer, :int], :int
  bind :erdos_renyi_game, [:pointer, :int, :int, :double, :bool, :bool], :int
  bind :forest_fire_game, [:pointer, :int, :double, :double, :int, :bool], :int
  bind :famous, [:pointer, :string], :int
  bind :full, [:pointer, :int, :bool, :bool], :int
  bind :ring, [:pointer, :int, :bool, :bool, :bool], :int
  bind :star, [:pointer, :int, :int, :int], :int
  bind :tree, [:pointer, :int, :int, :int], :int

  module Graph::Create

    def atlas i
      from :atlas, i
    end

    def erdos_renyi n, k
      from :erdos_renyi_game, 1, n, k, false, false
    end

    def famous name
      from :famous, name
    end

    def forest_fire n, k
      from :forest_fire_game, n, 0.05, 0.025, k, false
    end

    def full n
      from :full, n, false, false
    end

    def ring n
      from :ring, n, false, false, true
    end

    def star n
      from :star, n, 2, 0
    end

    def tree n, k
      from :tree, n, k, 2
    end

    private #-------------------------

    def from name, *args
      g = FFI::MemoryPointer.new :pointer
      Steffi.send("igraph_#{name}", g, *args)
      new g
    end
  end

  class Graph
    extend Graph::Create
  end
end