module Steffi

  module Igraph
    bind :vector_init, [:pointer, :long], :int
    bind :vector_e, [:pointer, :long], :double
    bind :vector_set, [:pointer, :long, :double], :void
    bind :vector_size, [:pointer], :long
    bind :vector_push_back, [:pointer, :double], :int
  end

  class Vector

    class Struct < FFI::Struct
      layout :stor_begin, :pointer,
             :stor_end,   :pointer,
             :end,        :pointer
    end

    include Enumerable

    def initialize
      @struct = Struct.new
      Igraph.vector_init ptr, 0
    end

    def ptr
      @struct.to_ptr
    end

    def << obj
      Igraph.vector_push_back ptr, obj.to_f
    end

    def [] i
      Igraph.vector_e ptr, i
    end

    def []= i, obj
      Igraph.vector_set ptr, i, obj.to_f
    end

    def size
      Igraph.vector_size ptr
    end

    def each
      0.upto(size-1) { |i| yield self[i] }
    end

    def to_s
      map { |f| f }
    end

  end

end