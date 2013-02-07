module Steffi

  module Igraph
    bind :community_multilevel, [:pointer, :pointer, :pointer, :pointer, :pointer], :int
  end

  class Graph
    def communities
      return @communities unless @communities.nil?

      membership = Vector.new
      Igraph.community_multilevel ptr, nil, membership.ptr, nil, nil
      @communities = membership
    end
  end
end