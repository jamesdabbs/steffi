module Steffi

  module Igraph
    bind :community_multilevel, [:pointer, :pointer, :pointer, :pointer, :pointer], :int
  end

  class Graph
    def community
      membership = Vector.new
      Igraph.community_multilevel ptr, nil, membership.ptr, nil, nil
      membership
    end
  end
end