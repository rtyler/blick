require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do |t|
end

task :default => ['protobuf:compile', 'spec']