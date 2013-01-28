require 'ffi'

module Steffi
  extend FFI::Library
  ffi_lib 'igraph'

  def self.bind name, in_t, out_t
    attach_function "igraph_#{name}", in_t, out_t
  end

  bind :vector_init_copy, [:pointer, :pointer, :long], :int
  bind :vector_e, [:pointer, :long], :double
  bind :vector_size, [:pointer], :long

  class Vector
    include Enumerable

    attr_accessor :ptr

    def initialize ptr
      @ptr = ptr
    end

    def size
      Steffi.igraph_vector_size @ptr
    end

    def [] i
      Steffi.igraph_vector_e @ptr, i
    end

    def each
      0.upto(size-1) { |i| yield self[i] }
    end

    class << self

      def from_a ary
        ptr = FFI::MemoryPointer.new :pointer
        c_ary = FFI::MemoryPointer.new :double, ary.size
        c_ary.put_array_of_double(0, ary.map { |n| n.to_f })
        Steffi.igraph_vector_init_copy ptr, c_ary, ary.size
        new ptr
      end

    end
  end
end