module Steffi
  class EdgeSet
    include Enumerable

    def initialize graph
      @graph = graph
    end

    def size
      Igraph.ecount @graph.pointer
    end

    def empty?
      size == 0
    end

    def << pair
      Igraph.add_edge @graph.pointer, pair.first, pair.last
    end

    def [] n
      from = FFI::MemoryPointer.new :int
      to   = FFI::MemoryPointer.new :int
      Igraph.edge @graph.pointer, n, from, to
      [from.get_int(0), to.get_int(0)]
    end

    def each
      0.upto size - 1 do |i|
        yield self[i]
      end
    end

    def find pair, error=false
      id = FFI::MemoryPointer.new :int
      Igraph.get_eid @graph.pointer, id, pair.first, pair.last, @graph.directed?, error
    end

    # def find_pairs *pairs
    #   edges = Vector.new
    #   error = false
    #   Igraph.get_eids @graph.pointer, edges.pointer, Vector.from_a(pairs), nil, @graph.directed?, error
    #   edges
    # end

    # def find_path *vertices
    #   edges = Vector.new
    #   error = false
    #   Igraph.get_eids @graph.pointer, edges.pointer, nil, Vector.from_a(pairs), nil, @graph.directed?, error
    #   edges
    # end
  end
end