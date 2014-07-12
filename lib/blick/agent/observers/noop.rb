require 'blick/agent/observer'

module Blick::Agent
  module Observers
    # The No-op observer is just a stub-class which exists to validate
    # enabled/disabled behavior inside of Blick::Agent as it Observers go
    #
    # This class genuinely doesn't do anything
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

      def self.platforms
        [].freeze
      end

      #######################################################################
      ### Observer execution/runtime
      #######################################################################

      # @raise [StandardError] If for some reason execute on this disabled
      #   Observer is called
      def execute
        raise StandardError, "#{self.class.name} should never execute!"
      end
    end
  end
end
