require 'spec_helper'
require 'blick/agent/observer'

describe Blick::Agent::Observer do
  describe '.registry' do
    subject { described_class.registry }
    it { should be_instance_of Array }
  end
end
