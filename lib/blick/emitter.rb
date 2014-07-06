
module Blick
  class Emitter
    # Emit is a instance-wide helper method for emitting protobuf messages
    # "upstream" for whatever "upstream" means for this particualr instance of
    # Blick.
    #
    # @param [Protobuf::Message] protobuf A protobuf to be serialized and
    #   emitted
    # @return [Boolean[ success of the emit operation
    def self.emit(protobuf)
      puts "Emitting #{protobuf.inspect}"
      return true
    end
  end
end
