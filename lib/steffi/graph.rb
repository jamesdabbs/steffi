require 'steffi/graph/constructors'
require 'steffi/graph/file'
require 'steffi/graph/cliques'

module Steffi

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

  end
end