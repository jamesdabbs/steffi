require 'ffi'

module Steffi

  module C
    extend FFI::Library
    ffi_lib :c

    attach_function :fopen, [:pointer, :pointer], :pointer
    attach_function :fclose, [:pointer], :int

    def self.open path, mode='r'
      stream = C.fopen path, mode
      result = yield stream if block_given?
      C.fclose stream
      result
    end
  end

  module Igraph
    extend FFI::Library
    ffi_lib :igraph

    def self.bind name, in_t, out_t
      attach_function :"igraph_#{name}", in_t, out_t
    end

    def self.method_missing name, *args, &block
      iname = :"igraph_#{name}"
      respond_to?(iname) ? send(iname, *args, &block) : super
    end
  end
end