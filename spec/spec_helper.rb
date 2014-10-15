require 'rspec'
require 'rspec/its'

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + '/../lib'))

Dir[File.expand_path(File.dirname(__FILE__) + '/support/**/*.rb')].each do |f|
  load f
end

RSpec.configure do |c|
end
