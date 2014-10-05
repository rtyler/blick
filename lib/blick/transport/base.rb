module Blick
  module Transport
    class Base
      def title
        raise NotImplementedError
      end

      def emit(message)
        raise NotImplementedError
      end
    end
  end
end
