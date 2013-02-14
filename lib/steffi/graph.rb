module Steffi

  module Igraph
    bind :write_graph_edgelist, [:pointer, :pointer], :int
    bind :write_graph_gml, [:pointer, :pointer, :pointer, :pointer], :int
    bind :destroy, [:pointer], :int
  end

  class Graph

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

    attr_reader :ptr

    def initialize opts={}
      @ptr = FFI::MemoryPointer.new Struct
      @directed = !!opts[:directed]
    end

    def directed?
      @directed
    end

    def file_format filename
      ext = filename.split('.').last
    end

    def dump path, format=nil
      format ||= file_format path
      C.open(path, 'w') do |stream|
        case format.to_sym
        when :edgelist
          Igraph.write_graph_edgelist ptr, stream
        when :gml
          Igraph.write_graph_gml ptr, stream, nil, nil
        else
          raise "Unrecognized file format: #{format}"
        end
      end
    end

    def to_hash opts={}
      color = opts[:color] || Proc.new { |n| communities[n] }
      {
        directed: directed?,
        nodes: vertices.map { |v| { name: v, group: color.call(v) } },
        links: edges.map { |e| { source: e.from, target: e.to, weight: 1 } }
      }
    end

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