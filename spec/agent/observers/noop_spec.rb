require 'spec_helper'
require 'blick/agent/observers/noop'

describe Blick::Agent::Observers::Noop do
  it_behaves_like 'an Observer'
end
