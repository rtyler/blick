require 'blick/transport/base'

module Blick
  module Transport
    class Noop < Base
      TITLE = 'No-op'.freeze

      def title
        return TITLE
      end
    end
  end
end
