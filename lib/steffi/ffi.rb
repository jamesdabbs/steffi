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

    # 2.1 Graph constructors and deconstructors
    bind :empty,       [:pointer, :int, :bool]
    bind :empty_attrs, [:pointer, :int, :bool, :pointer] # graph, vertex count, directed?, (void *) attributes
    bind :copy,        [:pointer, :pointer]
    bind :destroy,     [:pointer]

    # 2.2 Basic query operations
    bind :vcount, [:pointer], :int
    bind :ecount, [:pointer], :int
    bind :edge,   [:pointer, :int, :pointer, :pointer] # graph, edge #, &from, &to

    # graph, &edge #, from, to, directed?, error?
    bind :get_eid, [:pointer, :pointer, :int, :int, :bool, :bool]

    # graph, &[edge #], &[pairs], &[path], directed?, error?
    bind :get_eids, [:pointer, :pointer, :pointer, :pointer, :bool, :bool]

    # graph, &[edge #]. &[pairs], &[path], directed?, error?
    bind :get_eids_multi, [:pointer, :pointer, :pointer, :pointer, :bool, :bool]

    bind :neighbors,   [:pointer, :pointer, :int, :int] # graph, &[result], node, mode
    bind :incident,    [:pointer, :pointer, :int, :int] # graph, &[result], node, mode
    bind :is_directed, [:pointer], :bool                # graph => directed?

    # graph, &[results], vids, mode, loops?
    bind :degree, [:pointer, :pointer, :int, :bool]

    # 2.3 Adding and deleting vertices and edges
    bind :add_edge,        [:pointer, :int, :int]
    bind :add_edges,       [:pointer, :pointer, :pointer] # graph, [edges], (void *) attrs
    bind :add_vertices,    [:pointer, :int, :pointer]     # graph, id, (void *) attr
    bind :delete_edges,    [:pointer, :pointer]           # graph, eids
    bind :delete_vertices, [:pointer, :pointer]           # graph, vids

    # 2.4 Deprecated
    # igraph_adjacent
  end
end