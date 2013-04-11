module Steffi
  class VertexSet
    include Enumerable
    
    def initialize graph
      @graph = graph
    end

    def size
      Igraph.vcount @graph.pointer
    end

    def empty?
      size == 0
    end

    def [] n
      Vertex.new @graph, n
    end

    def each
      0.upto size - 1 do |i|
        yield self[i]
      end
    end
  end
end