class EdgeSet
  def initialize graph
    @graph = graph
  end

  def size
    Steffi::Igraph.ecount @graph.pointer
  end

  def empty?
    size == 0
  end
end