require 'helper'

describe Steffi::Igraph::Error do

  it 'handles errors gracefully' do
    # TODO: This test seems to halt execution if it fails. It'd be nice if there 
    # were a way to prevent that.
    expect { Steffi::Graph.famous 'non-existent' }.to raise_error(Steffi::Igraph::Error)
  end

end