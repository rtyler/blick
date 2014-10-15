require 'spec_helper'
require 'blick/transport/stdout'

describe Blick::Transport::Stdout do
  it_behaves_like 'a transport class'

  its(:title) { should eql 'Standard Out' }
end
