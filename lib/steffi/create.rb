module Steffi

  module Igraph
    bind :read_graph_edgelist, [:pointer, :pointer, :int, :bool], :int
    bind :atlas, [:pointer, :int], :int
    bind :cited_type_game, [:pointer, :int, :pointer, :pointer, :int, :bool], :int
    bind :erdos_renyi_game, [:pointer, :int, :int, :double, :bool, :bool], :int
    bind :forest_fire_game, [:pointer, :int, :double, :double, :int, :bool], :int
    bind :famous, [:pointer, :string], :int
    bind :full, [:pointer, :int, :bool, :bool], :int
    bind :ring, [:pointer, :int, :bool, :bool, :bool], :int
    bind :star, [:pointer, :int, :int, :int], :int
    bind :tree, [:pointer, :int, :int, :int], :int
  end

  class Graph

    class << self
      
      def load path
        stream = C.fopen path, 'r'
        g = from :read_graph_edgelist, stream, 0, false
        C.fclose stream
        g
      end

      def atlas i
        from :atlas, i
      end

      def citations n, p
        types = (0...n).to_a
        types = Vector.from_a(types).ptr
        attractivity = 1.0 / p
        prefs = [attractivity] * (n+1)
        prefs = Vector.from_a(prefs).ptr
        from :cited_type_game, n, types, prefs, 1, false
      end

      def erdos_renyi n, k
        from :erdos_renyi_game, 1, n, k, false, false
      end

      def famous name
        from :famous, name
      end

      def forest_fire n, k
        from :forest_fire_game, n, 0.01/k, 1, 2, false
      end

      def full n
        from :full, n, false, false
      end

      def ring n
        from :ring, n, false, false, true
      end

      def star n
        from :star, n, 2, 0
      end

      def tree n, k
        from :tree, n, k, 2
      end

      private #-------------------------------------------------------

      def from name, *args
        Graph.new do |ptr|
          Igraph.send name, ptr, *args
        end
      end

    end
  end
end