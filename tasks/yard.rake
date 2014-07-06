require 'yard'
require 'yard/rake/yardoc_task'

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb', '-', 'README.md', 'docs/**/*.md']
end
