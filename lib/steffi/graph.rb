module Steffi

  module Igraph
    bind :write_graph_edgelist, [:pointer, :pointer], :int
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

    def initialize 
      @ptr = FFI::MemoryPointer.new Struct
      yield self if block_given?
    end

    def dump path
      stream = C.fopen path, 'w'
      Igraph.write_graph_edgelist ptr, stream
      C.fclose stream
    end

  end
end