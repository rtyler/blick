require 'spec_helper'
require 'blick/agent/scheduler'

describe Blick::Agent::Scheduler do
  let(:scheduler) { described_class.new }

  describe '#run!' do
  end

  describe '#prepare_tasks' do
    subject { scheduler.send(:prepare_tasks) }

    before :each do
      expect(scheduler.tasks.size).to eql(0)
    end

    it 'should fill out the tasks' do
      expect(subject).to be true
      expect(scheduler.tasks.size).not_to eql(0)
    end
  end
end
