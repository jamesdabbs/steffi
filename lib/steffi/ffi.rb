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
    
    enum :neimode, [:out, 1, :in, 2, :all, 3, :total, 3]

    # 4.2.1 Graph constructors and deconstructors
    bind :empty,       [:pointer, :int, :bool]
    bind :empty_attrs, [:pointer, :int, :bool, :pointer] # graph, vertex count, directed?, (void *) attributes
    bind :copy,        [:pointer, :pointer]
    bind :destroy,     [:pointer]

    # 4.2.2 Basic query operations
    bind :vcount,   [:pointer], :int
    bind :ecount,   [:pointer], :int
    bind :edge,     [:pointer, :int, :pointer, :pointer]
    bind :get_eid,  [:pointer, :pointer, :int, :int, :bool, :bool]
    bind :get_eids, [:pointer, :pointer, :pointer, :pointer, :bool, :bool]

    # graph, &[edge #]. &[pairs], &[path], directed?, error?
    bind :get_eids_multi, [:pointer, :pointer, :pointer, :pointer, :bool, :bool]

    bind :neighbors,   [:pointer, :pointer, :int, :neimode]
    bind :incident,    [:pointer, :pointer, :int, :neimode] 
    bind :is_directed, [:pointer], :bool

    # graph, &[results], vids, mode, loops?
    bind :degree, [:pointer, :pointer, :int, :bool]

    # 4.2.3 Adding and deleting vertices and edges
    bind :add_edge,        [:pointer, :int, :int]
    bind :add_edges,       [:pointer, :pointer, :pointer] # graph, [edges], (void *) attrs
    bind :add_vertices,    [:pointer, :int, :pointer]     # graph, id, (void *) attr
    bind :delete_edges,    [:pointer, :pointer]           # graph, eids
    bind :delete_vertices, [:pointer, :pointer]           # graph, vids

    # 7.2.2
    bind :vector_init,      [:pointer, :long]            # vector, size
    bind :vector_init_copy, [:pointer, :pointer, :long]  # vector, data, length
    bind :vector_init_seq,  [:pointer, :double, :double] # vector, from, to
    bind :vector_copy,      [:pointer, :pointer]         # from, to
    bind :vector_destroy,   [:pointer]                   # vector

    # 7.2.3 Initializing elements
    bind :vector_null, [:pointer],          :void # vector
    bind :vector_fill, [:pointer, :double], :void # vector, value

    # 7.2.4 Accessing elements
    bind :vector_e,     [:pointer, :long], :double        # vector, pos => value
    bind :vector_e_ptr, [:pointer, :long], :pointer       # vector, pos => address
    bind :vector_set,   [:pointer, :long, :double], :void # vector, pos, value
    bind :vector_tail,  [:pointer], :double               # vector => value

    # 7.2.5 Vector views
    bind :vector_view, [:pointer, :pointer, :long], :pointer # vector, data, len => vector
    
    # 7.2.6 Copying vectors
    bind :vector_copy_to, [:pointer, :pointer], :void # vector, array
    bind :vector_update,  [:pointer, :pointer]        # to, from
    bind :vector_append,  [:pointer, :pointer]        # to, from
    bind :vector_swap,    [:pointer, :pointer]        # v1, v2

    # 7.2.7 Exchanging elements
    # ...
    # 7.2.8 Vector operations
    # ...
    # 7.2.9 Vector comparisons
    # ...
    # 7.2.10 Finding minimum and maximum
    # ...
    # 7.2.11 Vector properties
    # ...
    # 7.2.12 Searching for elements
    # ...
    # 7.2.13 Resizing operations
    # ...
    # 7.2.14 Sorting
    # ...
    # 7.2.15 Set operations on sorted vectors
    # ...
    # 7.2.16 Pointer vectors
    # ...
  end
end