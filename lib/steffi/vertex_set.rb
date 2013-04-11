class VertexSet
  def initialize graph
    @graph = graph
  end

  def size
    Steffi::Igraph.vcount @graph.pointer
  end

  def empty?
    size == 0
  end
end