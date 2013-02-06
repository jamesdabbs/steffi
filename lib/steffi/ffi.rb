require 'ffi'

module Steffi

  module C
    extend FFI::Library
    ffi_lib :c

    attach_function :fopen, [:pointer, :pointer], :pointer
    attach_function :fclose, [:pointer], :int
  end

  module Igraph
    extend FFI::Library
    ffi_lib File.expand_path('../../../ext/libigraph.0.6.dylib', __FILE__)

    def self.bind name, in_t, out_t
      attach_function :"igraph_#{name}", in_t, out_t
    end

    def self.method_missing name, *args, &block
      iname = :"igraph_#{name}"
      respond_to?(iname) ? send(iname, *args, &block) : super
    end
  end
end