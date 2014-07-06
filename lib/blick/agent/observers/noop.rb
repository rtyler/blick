require 'blick/agent/observer'

module Blick::Agent
  module Observers
    class Noop < Observer
      #######################################################################
      ### Observer registry/internals
      #######################################################################
      def self.name
        'Blick No-Op Observer'
      end

      def self.description
        'An observer which exists only to be disabled'
      end

      def self.enabled?
        false
      end

      def self.interval
        300
      end

      #######################################################################
      ### Observer execution/runtime
      #######################################################################

      def execute
        raise StandardError, "#{self.class.name} should never execute!"
      end
    end
  end
end
