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

    # igraph functions always start with igraph_ and typically return an error code
    def self.bind name, in_t, out_t=:int
      attach_function :"igraph_#{name}", in_t, out_t
    end

    def self.method_missing name, *args, &block
      if name =~ /^igraph_/
        super
      else
        send :"igraph_#{name}", *args, &block
      end
    end
  end
end

%w{ basic vector constructors structure cliques }.each do |f|
  require_relative "ffi/#{f}"
end