require 'spec_helper'
require 'blick/emitter'

describe Blick::Emitter do
  describe '.emit' do
    subject { described_class.emit(msg) }
    let(:msg) { double('Mock Protobuf::Message') }

    it { should be true }
  end
end
