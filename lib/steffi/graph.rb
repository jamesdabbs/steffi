module Steffi

  module Igraph
    bind :write_graph_edgelist, [:pointer, :pointer], :int
    bind :write_graph_gml, [:pointer, :pointer, :pointer, :pointer], :int
  end

  class Graph
    attr_reader :pointer

    class Struct < FFI::ManagedStruct
      layout :n,        :int,
             :directed, :bool,
             :from,     Vector::Struct,
             :to,       Vector::Struct,
             :oi,       Vector::Struct,
             :ii,       Vector::Struct,
             :os,       Vector::Struct,
             :is,       Vector::Struct,
             :attr,     :pointer

      def self.release ptr
        Igraph.destroy ptr
      end
    end

    def self.empty size, directed=false
      new { |graph| Igraph.empty graph.pointer, size, directed }
    end

    def self.copy graph
      new { |copy| Igraph.copy copy.pointer, graph.pointer }
    end

    def destroy
      Igraph.destroy pointer
    end

    def directed?
      Igraph.is_directed pointer
    end

    def vertices
      VertexSet.new self
    end

    def edges
      EdgeSet.new self
    end

    private

    def initialize
      @pointer = FFI::MemoryPointer.new Struct
      yield self if block_given?
    end

    # def file_format filename
    #   ext = filename.split('.').last
    # end

    # def dump path, format=nil
    #   format ||= file_format path
    #   C.open(path, 'w') do |stream|
    #     case format.to_sym
    #     when :edgelist
    #       Igraph.write_graph_edgelist ptr, stream
    #     when :gml
    #       Igraph.write_graph_gml ptr, stream, nil, nil
    #     else
    #       raise "Unrecognized file format: #{format}"
    #     end
    #   end
    # end

    # def to_hash opts={}
    #   color = opts[:color] || Proc.new { |n| communities[n] }
    #   {
    #     directed: directed?,
    #     nodes: vertices.map { |v| { name: v, group: color.call(v) } },
    #     links: edges.map { |e| { source: e.from, target: e.to, weight: 1 } }
    #   }
    # end

    private #-------------------------------------------------------

    def self.constructor name, &block
      define_method name, &block

      Graph.define_singleton_method name do |*args|
        opts = args.last.is_a?(Hash) ? args.pop : {}
        g = Graph.new opts
        g.send name, *args
        g
      end
    end

  end
end