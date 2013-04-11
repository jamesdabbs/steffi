%w{ constructors structure cliques file vertex_selector }.each do |f|
  require "steffi/graph/#{f}"
end

module Steffi

  class Graph
    attr_reader :pointer, :vertices, :edges

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

    def subgraph vids
      Graph.new do |subgraph|
        vs = VertexSelector.from_a vids
        Igraph.subgraph @pointer, subgraph.pointer, vs
      end
    end

    private

    def initialize
      @pointer  = FFI::MemoryPointer.new Struct
      @vertices = VertexSet.new self
      @edges    = EdgeSet.new self
      yield self if block_given?
    end

  end
end