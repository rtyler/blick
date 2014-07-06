require 'spec_helper'
require 'blick/agent/observers/heartbeat'

describe Blick::Agent::Observers::Heartbeat do
  it_behaves_like 'an Observer'

  context 'class methods' do
    subject { described_class }
    it { should be_enabled }
  end
end
