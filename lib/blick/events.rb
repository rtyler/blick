require 'socket'
require 'protobuf'

require 'blick/events.pb'

module Blick
  module Events
    def self.hostname
      return @hostname if @hostname
      @hostname = Socket.gethostname
    end

    def self.header
      return Blick::Events::Header.new(:hostname => self.hostname,
                                       :timestamp => Time.now.utc.iso8601)
    end
  end
end
