require 'spec_helper'
require 'blick/agent/observers/ruby_runtime'

describe Blick::Agent::Observers::RubyRuntime do
  it_behaves_like 'an Observer'

  context 'instance methods' do
    let(:runtime) { described_class.new }

    describe '#execute' do
      it 'should emit' do
        expect(Blick::Emitter).to receive(:emit).and_return(true)
        expect(runtime.execute).to be true
      end
    end
  end
end
