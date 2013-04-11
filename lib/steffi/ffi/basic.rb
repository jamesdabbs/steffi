module Steffi
  module Igraph
    enum :neimode, [:out, 1, :in, 2, :all, 3, :total, 3]

    # 4.2.1 Graph constructors and deconstructors
    bind :empty,         [:pointer, :int, :bool]
    bind :copy,          [:pointer, :pointer]
    bind :destroy,       [:pointer]
    # bind :empty_attrs, [:pointer, :int, :bool, :pointer] # graph, vertex count, directed?, (void *) attributes

    # 4.2.2 Basic query operations
    bind :vcount,           [:pointer], :int
    bind :ecount,           [:pointer], :int
    bind :edge,             [:pointer, :int, :pointer, :pointer]
    bind :get_eid,          [:pointer, :pointer, :int, :int, :bool, :bool]
    bind :get_eids,         [:pointer, :pointer, :pointer, :pointer, :bool, :bool]
    bind :neighbors,        [:pointer, :pointer, :int, :neimode]
    bind :incident,         [:pointer, :pointer, :int, :neimode] 
    bind :is_directed,      [:pointer], :bool
    # bind :get_eids_multi, [:pointer, :pointer, :pointer, :pointer, :bool, :bool] # graph, &[edge #]. &[pairs], &[path], directed?, error?
    # bind :degree,         [:pointer, :pointer, :int, :bool] # graph, &[results], vids, mode, loops?

    # 4.2.3 Adding and deleting vertices and edges
    bind :add_edge,          [:pointer, :int, :int]
    # bind :add_edges,       [:pointer, :pointer, :pointer] # graph, [edges], (void *) attrs
    # bind :add_vertices,    [:pointer, :int, :pointer]     # graph, id, (void *) attr
    # bind :delete_edges,    [:pointer, :pointer]           # graph, eids
    # bind :delete_vertices, [:pointer, :pointer]           # graph, vids
  end
end