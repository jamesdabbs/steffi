module Steffi
  class EdgeSet
    include Enumerable

    ERROR = false # FIXME: add error handling

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
      Edge.new @graph, from.get_int(0), to.get_int(0)
    end

    def each
      0.upto size - 1 do |i|
        yield self[i]
      end
    end

    def find pair, error=false
      FFI::MemoryPointer.new(:int).tap do |id|
        Igraph.get_eid @graph.pointer, id, pair.first, pair.last, @graph.directed?, error
      end.get_int 0
    end

    def find_pairs *pairs
      Vector.null.tap do |edges|
        Igraph.get_eids @graph.pointer, edges.pointer, Vector.from_a(pairs.flatten).pointer, nil, @graph.directed?, ERROR
      end.map &:to_i
    end

    def find_path *vertices
      Vector.null.tap do |edges|
        Igraph.get_eids @graph.pointer, edges.pointer, nil, Vector.from_a(*vertices).pointer, @graph.directed?, ERROR
      end.map &:to_i
    end
  end
end