source 'https://rubygems.org'

# Task runner for dev and built jars
gem 'rake'

# Gem for defining protobuf messages and rpcs
gem 'protobuf'
# Useful for managing futures/timers/etc
gem 'concurrent-ruby'

gem 'ffi-rzmq', :platform => :mri
gem 'jrzmq', :platform => :jruby

gem 'pry'
gem 'sinatra'

group :development do
  gem 'shotgun', :platform => :mri
end

group :test do
  gem 'rspec'
  # For creating the executable package
  gem 'warbler'

  gem 'yard'
end
