
shared_examples_for 'a transport class' do
  it { should respond_to :title }
  it { should respond_to :emit }
end
