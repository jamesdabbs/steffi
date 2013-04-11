module Steffi
  class Graph
    def clique_number
      FFI::MemoryPointer.new(:int).tap do |result|
        Igraph.clique_number @pointer, result
      end.get_int(0)
    end

    def independence_number
      FFI::MemoryPointer.new(:int).tap do |result|
        Igraph.independence_number @pointer, result
      end.get_int(0)
    end
  end
end