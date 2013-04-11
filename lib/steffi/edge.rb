module Steffi
  class Edge
    attr_reader :graph, :from, :to

    def initialize graph, from, to
      @graph, @from, @to = graph, from, to
    end

    def to_pair
      [@from, @to]
    end
  end
end