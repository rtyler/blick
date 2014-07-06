
shared_examples 'an Observer' do
  context 'class methods' do
    subject(:observer) { described_class }

    describe '.name' do
      subject { observer.name }
      it { should be_instance_of String }
    end

    describe '.description' do
      subject { observer.description }
      it { should be_instance_of String }
    end

    describe '.interval' do
      subject { observer.interval }

      it { should be_instance_of Fixnum }
      it { should be > 0 }
    end

    it { should respond_to :enabled? }

    describe '.platforms' do
      subject { observer.platforms }
      it { should be_instance_of Array }
    end
  end

  context 'instance methods' do
    let(:observer) { described_class.new }
    it { should respond_to :prepare }
    it { should respond_to :execute }
    it { should respond_to :cleanup }
  end
end
