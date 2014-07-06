require 'spec_helper'
require 'blick/agent/observers/heartbeat'

describe Blick::Agent::Observers::Heartbeat do
  it_behaves_like 'an Observer'

  context 'class methods' do
    subject { described_class }
    it { should be_enabled }
  end

  describe 'instance methods' do
    let(:heartbeat) { described_class.new }

    describe '#execute' do
      it 'should emit a heartbeat' do
        expect(Blick::Emitter).to \
          receive(:emit).with(kind_of(Blick::Events::Heartbeat)).and_return(true)

        expect(heartbeat.execute).to be true
      end
    end

    describe '#enabled_observers' do
      subject(:observers) { heartbeat.enabled_observers }

      it { should be_instance_of Array }
      it 'should include the Heartbeat' do
        expect(observers).to include(described_class.name)
      end
    end
  end
end
