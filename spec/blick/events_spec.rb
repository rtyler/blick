require 'spec_helper'
require 'blick/events'

describe Blick::Events do
  describe '.hostname' do
    before :each do
      described_class.instance_variable_set(:@hostname, nil)
    end

    it 'should call Socket.gethostname' do
      expect(Socket).to receive(:gethostname).and_return('rspec')
      expect(described_class.hostname).to eql('rspec')
    end

    it 'should cache Socket.gethostname' do
      expect(Socket).to receive(:gethostname).once.and_return('rspec')
      5.times do
        expect(described_class.hostname).to eql('rspec')
      end
    end
  end

  describe '.header' do
    subject(:header) { described_class.header }

    it { should be_instance_of Blick::Events::Header }
  end
end
