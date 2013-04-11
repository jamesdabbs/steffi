module Steffi

  module Igraph
    bind :write_graph_edgelist, [:pointer, :pointer], :int
    bind :write_graph_gml,      [:pointer, :pointer, :pointer, :pointer], :int
  end

  class Graph

    # constructor :load  do |path, format=nil|
    #   format ||= file_format path
    #   C.open(path, 'r') do |stream|
    #     case format.to_sym
    #     when :edgelist
    #       Igraph.read_graph_edgelist ptr, stream, 0, directed?
    #     when :gml
    #       Igraph.read_graph_gml ptr, stream
    #     else
    #       raise "Unrecognized file format: #{format}"
    #     end
    #   end
    # end

    # def file_format filename
    #   ext = filename.split('.').last
    # end

    # def dump path, format=nil
    #   format ||= file_format path
    #   C.open(path, 'w') do |stream|
    #     case format.to_sym
    #     when :edgelist
    #       Igraph.write_graph_edgelist ptr, stream
    #     when :gml
    #       Igraph.write_graph_gml ptr, stream, nil, nil
    #     else
    #       raise "Unrecognized file format: #{format}"
    #     end
    #   end
    # end

    # def to_hash opts={}
    #   color = opts[:color] || Proc.new { |n| communities[n] }
    #   {
    #     directed: directed?,
    #     nodes: vertices.map { |v| { name: v, group: color.call(v) } },
    #     links: edges.map { |e| { source: e.from, target: e.to, weight: 1 } }
    #   }
    # end

  end

end