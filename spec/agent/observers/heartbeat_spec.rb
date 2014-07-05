require 'spec_helper'
require 'blick/agent/observers/heartbeat'

describe Blick::Agent::Observers::Heartbeat do
  it_behaves_like 'an Observer'

  subject(:heartbeat) { described_class.new }

  describe '.enabled' do
    subject { described_class.enabled }
    it { should be true }
  end
end
