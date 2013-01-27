module Steffi
  class Edge
    attr_accessor :graph, :from, :to

    def initialize graph,from,to
      @graph = graph
      @from = from
      @to = to
    end

    def to_s
      "(#{from},#{to})"
    end
  end
end