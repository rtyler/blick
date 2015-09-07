require 'singleton'
require 'blick/transport'

module Blick
  class Emitter
    include Singleton

    # Emit is a instance-wide helper method for emitting protobuf messages
    # "upstream" for whatever "upstream" means for this particualr instance of
    # Blick.
    #
    # @param [Protobuf::Message] protobuf A protobuf to be serialized and
    #   emitted
    # @return [Boolean[ success of the emit operation
    def self.emit(protobuf)
      return self.instance.emit(protobuf)
    end

    def initialize(*args)
      @transport = Blick::Transport::Stdout.new
    end

    def emit(protobuf)
      @transport.emit(protobuf)
    end
  end
end
