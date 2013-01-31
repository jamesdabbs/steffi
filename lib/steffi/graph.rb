module Steffi

  bind :write_graph_edgelist, [:pointer, :pointer], :int

  class Graph
    def initialize graph_ptr
      @graph_ptr = graph_ptr
    end 

    def dump path
      stream = C.fopen path, 'w'
      Steffi.igraph_write_graph_edgelist @graph_ptr, stream
      C.fclose stream
    end
  end
end