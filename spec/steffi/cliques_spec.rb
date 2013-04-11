require 'helper'

describe 'Cliques' do
  subject { Steffi::Graph.famous 'zachary' }

  its(:clique_number)       { should == 5 }
  its(:independence_number) { should == 20 }
end