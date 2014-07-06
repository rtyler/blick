require 'socket'
require 'protobuf'

require 'blick/events.pb'

module Blick
  module Events
    # Return the hostname of the current host according to +Socket#gethostname+
    #
    # @return [String] hostname
    def self.hostname
      return @hostname if @hostname
      @hostname = Socket.gethostname
    end

    # Generate a new {Blick::Events::Header} message with the current
    # {hostname} and ISO-8601 formatted timestamp
    #
    # @return [Blick::Events::Header]
    def self.header
      return Blick::Events::Header.new(:hostname => self.hostname,
                                       :timestamp => Time.now.utc.iso8601)
    end
  end
end
