module Steffi
  module Igraph
    # 15.1 Cliques
    # bind :cliques,         [:pointer, :pointer, :int, :int]
    # bind :largest_cliques, [:pointer, :pointer]
    # bind :maximal_cliques, [:pointer, :pointer, :int, :int] 
    bind :clique_number,   [:pointer, :pointer]

    # 15.2 Independent vertex sets
    # bind :independent_vertex_sets,         [:pointer, :pointer, :int, :int]
    # bind :largest_independent_vertex_sets, [:pointer, :pointer] 
    # bind :maximal_independent_vertex_sets, [:pointer, :pointer]
    bind :independence_number,             [:pointer, :pointer]
  end
end