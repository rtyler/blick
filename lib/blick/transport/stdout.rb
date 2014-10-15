require 'blick/transport/base'

module Blick
  module Transport
    class Stdout < Base
      TITLE = 'Standard Out'.freeze

      def title
        return TITLE
      end

      def emit(message)
        puts "Emitting #{message.inspect}"
        STDOUT.flush
        return true
      end
    end
  end
end
