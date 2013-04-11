module Steffi
  class Vertex
    def initialize graph, id
      @graph, @id = graph, id
    end

    def neighbors
      mode = 3 # IGRAPH_ALL / FIXME: define and use enum
      v = Vector.null
      Igraph.neighbors @graph.pointer, v.pointer, @id, mode
      v.to_a
    end

    def incident
      mode = 3 # IGRAPH_ALL / FIXME: define and use enum
      v = Vector.null
      Igraph.incident @graph.pointer, v.pointer, @id, mode
      v.map &:to_i
    end
  end
end