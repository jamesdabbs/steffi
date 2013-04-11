module Steffi
  class VertexSet
    def initialize graph
      @graph = graph
    end

    def size
      Igraph.vcount @graph.pointer
    end

    def empty?
      size == 0
    end
  end
end