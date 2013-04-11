module Steffi
  module Igraph
    enum :erdos_renyi, [:gnp, :gnm]
    enum :star_mode,   [:out, :in, :undirected, :mutual]
    enum :tree_mode,   [:out, :in, :undirected]

    bind :read_graph_edgelist, [:pointer, :pointer, :int, :bool], :int
    bind :read_graph_gml,      [:pointer, :pointer], :int
    bind :atlas,               [:pointer, :int], :int
    bind :cited_type_game,     [:pointer, :int, :pointer, :pointer, :int, :bool], :int
    bind :erdos_renyi_game,    [:pointer, :int, :int, :double, :bool, :bool], :int
    bind :forest_fire_game,    [:pointer, :int, :double, :double, :int, :bool], :int
    bind :famous,              [:pointer, :string], :int
    bind :full,                [:pointer, :int, :bool, :bool], :int
    bind :ring,                [:pointer, :int, :bool, :bool, :bool], :int
    bind :star,                [:pointer, :int, :star_mode, :int], :int
    bind :tree,                [:pointer, :int, :int, :int], :int
  end
end