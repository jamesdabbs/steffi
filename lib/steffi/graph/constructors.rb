module Steffi

  class Graph

    class << self

      def atlas i
        new { |graph| Igraph.atlas graph.pointer, i }
      end

      def citations n, types=nil, pref=nil, edges_per_step=1, directed=false
        # TODO: better handling of vector arguments, defaults
        types ||= (0...n).to_a
        types   = Vector.from_a(types).pointer
        pref  ||= [1.0 / (n+1)] * (n+1)
        pref    = Vector.from_a(pref).pointer
        new { |graph| Igraph.cited_type_game graph.pointer, n, types, pref, edges_per_step, directed }
      end

      def erdos_renyi n, k, type=:gnm, directed=false, loops=false
        new { |graph| Igraph.erdos_renyi_game graph.pointer, type, n, k, directed, loops }
      end

      def famous name
        new { |graph| Igraph.famous graph.pointer, name.to_s }
      end

      def forest_fire n, fw, bw, ambassadors, directed=false
        new { |graph| Igraph.forest_fire_game graph.pointer, n, fw, bw, ambassadors, directed }
      end

      def full n, directed=false, loops=false
        new { |graph| Igraph.full graph.pointer, n, directed, loops }
      end

      def ring n, directed=false, mutual=false, circular=true
        new { |graph| Igraph.ring graph.pointer, n, directed, mutual, circular }
      end

      def star n, mode=:undirected, center=0
        new { |graph| Igraph.star graph.pointer, n, mode, center }
      end

      def tree n, children, mode=:undirected
        new { |graph| Igraph.tree graph.pointer, n, children, mode }
      end

    end
  end
end