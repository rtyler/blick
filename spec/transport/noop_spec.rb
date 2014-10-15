require 'spec_helper'
require 'blick/transport/noop'

describe Blick::Transport::Noop do
  it_behaves_like 'a transport class'
end
