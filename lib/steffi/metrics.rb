module Steffi
  module Igraph
    bind :diameter, [:pointer, :pointer, :pointer, :pointer, :pointer, :bool, :int], :int
    bind :ecount,   [:pointer], :int
    bind :vcount,   [:pointer], :int

    bind :edge,     [:pointer, :int, :pointer, :pointer], :int
  end

  class Graph
    def diameter
      d = FFI::MemoryPointer.new :int
      Igraph.diameter ptr, d, nil, nil, nil, @directed, 1
      d.get_int 0
    end

    def ecount
      Igraph.ecount ptr
    end

    def vcount
      Igraph.vcount ptr
    end

    def stats
      Hash[ %w{ diameter ecount vcount }.map { |n| [ n, send(n) ] } ]
    end

    def edge i
      from = FFI::MemoryPointer.new :int
      to = FFI::MemoryPointer.new :int
      Igraph.edge ptr, i, from, to
      Edge.new self, from.get_int(0), to.get_int(0)
    end

    def edges
      0.upto(ecount - 1).map { |i| edge i }
    end

    def vertices
      0.upto(vcount - 1).to_a
    end

  end
end