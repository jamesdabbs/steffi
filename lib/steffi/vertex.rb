module Steffi
  class Vertex
    def initialize graph, id
      @graph, @id = graph, id
    end

    def neighbors mode=:all
      Vector.null.tap do |v|
        Igraph.neighbors @graph.pointer, v.pointer, @id, mode
      end.to_a
    end

    def incident mode=:all
      Vector.null.tap do |v|
        Igraph.incident @graph.pointer, v.pointer, @id, mode
      end.map &:to_i
    end
  end
end