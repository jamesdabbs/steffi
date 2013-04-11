module Steffi
  module Igraph
    bind :vs_vector_small, [:pointer, :varargs]
  end

  class Graph

    private # -----

    class VertexSelector
      attr_reader :pointer

      class Struct < FFI::ManagedStruct
        layout

        def self.release ptr
          Igraph.vs_destroy ptr
        end
      end

      def self.from_a ary
        varargs = ary.map { |v| [:int, v] }.flatten
        new { |vs| Igraph.vs_vector_small vs.pointer, *varargs, :int, -1 }
      end

      private # -----

      def initialize
        @pointer = FFI::MemoryPointer.new Struct
        yield self if block_given?
      end
    end
  end
end