%w{
  ffi
  error
  vector
  
  graph
  vertex
  vertex_set
  edge
  edge_set

  metrics
  communities
}.each { |mod| require "steffi/#{mod}" }

module Steffi
end