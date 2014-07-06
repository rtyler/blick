
module Blick
  module Agent
    class Observer
      #  Registry of observers available in the runtime
      #
      #  @return [Array] Collection of +Blick::Agent::Observer+ instances
      def self.registry
        @register ||= []
      end

      def self.enabled?
        false
      end

      def self.interval
        raise NotImplementedError, 'Subclasses of Observer must implement .interval'
      end

      def self.name
        raise NotImplementedError, 'Subclasses of Observer must implement .name'
      end

      def self.description
        ''
      end

      def self.platforms
        raise NotImplementedError, 'Subclasses of Observer must implement .platforms'
      end


      def prepare
      end

      def execute
        raise NotImplementedError, "Subclasses of Observer must implement #execute"
      end

      def cleanup
      end

      def self.run!
        observer = self.new
        observer.prepare
        observer.execute
        observer.cleanup
      end

      private

      def self.inherited(subclass)
        self.registry << subclass
      end
    end
  end
end
