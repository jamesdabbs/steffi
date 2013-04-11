module Steffi

  module Igraph
    enum :star_mode, [:out, :in, :undirected, :mutual]
    enum :tree_mode, [:out, :in, :undirected]

    bind :read_graph_edgelist, [:pointer, :pointer, :int, :bool], :int
    bind :read_graph_gml, [:pointer, :pointer], :int
    bind :atlas, [:pointer, :int], :int
    bind :cited_type_game, [:pointer, :int, :pointer, :pointer, :int, :bool], :int
    bind :erdos_renyi_game, [:pointer, :int, :int, :double, :bool, :bool], :int
    bind :forest_fire_game, [:pointer, :int, :double, :double, :int, :bool], :int
    bind :famous, [:pointer, :string], :int
    bind :full, [:pointer, :int, :bool, :bool], :int
    bind :ring, [:pointer, :int, :bool, :bool, :bool], :int
    bind :star, [:pointer, :int, :star_mode, :int], :int
    bind :tree, [:pointer, :int, :int, :int], :int
  end

  class Graph

    class << self

      # constructor :load  do |path, format=nil|
      #   format ||= file_format path
      #   C.open(path, 'r') do |stream|
      #     case format.to_sym
      #     when :edgelist
      #       Igraph.read_graph_edgelist ptr, stream, 0, directed?
      #     when :gml
      #       Igraph.read_graph_gml ptr, stream
      #     else
      #       raise "Unrecognized file format: #{format}"
      #     end
      #   end
      # end

      def atlas i
        new { |graph| Igraph.atlas graph.pointer, i }
      end

      # constructor :citations do |n, p|
      #   types = (0...n).to_a
      #   types = Vector.from_a(types).ptr
      #   prefs = [1.0 / p] * (n+1)
      #   prefs = Vector.from_a(prefs).ptr
      #   Igraph.cited_type_game ptr, n, types, prefs, 1, directed?
      # end

      # constructor :erdos_renyi do |n, k|
      #   Igraph.erdos_renyi_game ptr, 1, n, k, directed?, false
      # end

      def famous name
        new { |graph| Igraph.famous graph.pointer, name.to_s }
      end

      # constructor :forest_fire do |n, k|
      #   Igraph.forest_fire_game ptr, n, 0.01/k, 1, 2, directed?
      # end

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