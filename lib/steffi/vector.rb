module Steffi
  module Igraph
    bind :vector_push_back, [:pointer, :double]
    bind :vector_size,      [:pointer], :int
  end

  class Vector
    class Struct < FFI::ManagedStruct
      layout :stor_begin, :pointer,
             :stor_end,   :pointer,
             :end,        :pointer

      def self.release ptr
        Igraph.vector_destroy ptr
      end
    end

    def self.null
      new { |v| Igraph.vector_init v.pointer, 0 }
    end

    def self.from_a ary
      new do |v| 
        Igraph.vector_init v.pointer, 0
        ary.each { |i| v << i }
      end
    end

    def self.from_slice slice
      raise "Slices should be inclusive" if slice.exclude_end?
      new { |v| Igraph.vector_init_seq v.pointer, slice.first, slice.last }
    end

    include Enumerable

    attr_reader :pointer

    def initialize
      @pointer = FFI::MemoryPointer.new Vector::Struct
      yield self if block_given?
      self
    end

    def length
      Igraph.vector_size @pointer
    end

    def << obj
      Igraph.vector_push_back @pointer, obj.to_f
    end

    def [] i
      Igraph.vector_e @pointer, i
    end

    def []= i, obj
      Igraph.vector_set @pointer, i, obj.to_f
    end

    def tail
      Igraph.vector_tail @pointer
    end

    def each
      0.upto length - 1 do |i| 
        yield self[i]
      end
    end

    def empty?
      Igraph.vector_empty @pointer
    end

    def sum
      Igraph.vector_sum @pointer
    end

    def product
      Igraph.vector_prod @pointer
    end
  end
end