module Steffi
  module Igraph
    # 7.2.2
    bind :vector_init,        [:pointer, :long]
    bind :vector_init_seq,    [:pointer, :double, :double]
    # bind :vector_init_copy, [:pointer, :pointer, :long]  # vector, data, length
    # bind :vector_copy,      [:pointer, :pointer]         # from, to
    # bind :vector_destroy,   [:pointer]                   # vector

    # 7.2.3 Initializing elements
    # bind :vector_null, [:pointer],          :void # vector
    # bind :vector_fill, [:pointer, :double], :void # vector, value

    # 7.2.4 Accessing elements
    bind :vector_e,       [:pointer, :long], :double
    bind :vector_set,     [:pointer, :long, :double], :void
    bind :vector_tail,    [:pointer], :double
    # bind :vector_e_ptr, [:pointer, :long], :pointer # vector, pos => address

    # 7.2.5 Vector views
    # bind :vector_view, [:pointer, :pointer, :long], :pointer # vector, data, len => vector
    
    # 7.2.6 Copying vectors
    # bind :vector_copy_to, [:pointer, :pointer], :void # vector, array
    # bind :vector_update,  [:pointer, :pointer]        # to, from
    # bind :vector_append,  [:pointer, :pointer]        # to, from
    # bind :vector_swap,    [:pointer, :pointer]        # v1, v2

    # 7.2.7 Exchanging elements
    # ...
    # 7.2.8 Vector operations
    # ...
    # 7.2.9 Vector comparisons
    # ...
    # 7.2.10 Finding minimum and maximum
    # ...

    # 7.2.11 Vector properties
    bind :vector_empty,           [:pointer], :bool
    bind :vector_size,            [:pointer], :long
    bind :vector_sum,             [:pointer], :double                 # vector => sum
    bind :vector_prod,            [:pointer], :double                 # vector => prod
    # bind :vector_capacity,      [:pointer], :long                   # vector => alloc'd cap
    # bind :vector_isininterval,  [:pointer, :double, :double], :bool # vector, low, high => pass?
    # bind :vector_maxdifference, [:pointer, :pointer], :double       # v1, v2 => max termwise diff

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