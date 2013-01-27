module Steffi
  bind :diameter, [:pointer, :pointer, :pointer, :pointer, :pointer, :int, :int], :int
  bind :ecount,   [:pointer], :int
  bind :vcount,   [:pointer], :int

  bind :edge,     [:pointer, :int, :pointer, :pointer], :int

  class Graph
    def diameter
      d = FFI::MemoryPointer.new :int
      Steffi.igraph_diameter @graph_ptr, d, nil, nil, nil, 0, 1
      d.get_int 0
    end

    def ecount
      Steffi.igraph_ecount @graph_ptr
    end

    def vcount
      Steffi.igraph_vcount @graph_ptr
    end

    def stats
      Hash[ %w{ diameter ecount vcount }.map { |n| [ n, send(n) ] } ]
    end

    def edge i
      from = FFI::MemoryPointer.new :int
      to = FFI::MemoryPointer.new :int
      Steffi.igraph_edge @graph_ptr, i, from, to
      Edge.new self, from.get_int(0), to.get_int(0)
    end

    def edges
      0.upto(ecount - 1).map { |i| edge i }
    end

  end
end