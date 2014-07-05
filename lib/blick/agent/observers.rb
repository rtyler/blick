require 'blick/agent/observer'

# Load all our observers
Dir[File.expand_path(File.dirname(__FILE__) + '/observers/**/*.rb')].each do |f|
  require f
end
