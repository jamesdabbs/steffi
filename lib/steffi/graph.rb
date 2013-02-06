module Steffi

  module Igraph
    bind :write_graph_edgelist, [:pointer, :pointer], :int
  end

  class Graph

    class Struct < FFI::Struct
      layout :n,        :int,
             :directed, :bool,
             :from,     Vector::Struct,
             :to,       Vector::Struct,
             :oi,       Vector::Struct,
             :ii,       Vector::Struct,
             :os,       Vector::Struct,
             :is,       Vector::Struct,
             :attr,     :pointer
    end

    def initialize 
      @struct = Struct.new
      yield ptr if block_given?
    end

    def ptr
      @struct.to_ptr
    end

    def dump path
      stream = C.fopen path, 'w'
      Igraph.write_graph_edgelist ptr, stream
      C.fclose stream
    end

  end
end