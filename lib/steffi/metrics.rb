module Steffi
  module Igraph
    bind :diameter, [:pointer, :pointer, :pointer, :pointer, :pointer, :bool, :int], :int
  end

  class Graph
    def diameter
      d = FFI::MemoryPointer.new :int
      Igraph.diameter ptr, d, nil, nil, nil, @directed, 1
      d.get_int 0
    end

    def stats
      Hash[ %w{ diameter ecount vcount }.map { |n| [ n, send(n) ] } ]
    end
  end
end