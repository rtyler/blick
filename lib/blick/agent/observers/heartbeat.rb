require 'blick/events'
require 'blick/agent/observer'

module Blick::Agent
  module Observers
    class Heartbeat < Observer
      #######################################################################
      ### Observer registry/internals
      #######################################################################
      def self.name
        'Blick Internal Heartbeat'
      end

      def self.description
        'An observer which emits periodic heartbeats'
      end

      def self.enabled
        true
      end

      # @return [Fixnum] number of seconds to run this observer
      def self.interval
        60
      end

      def self.platforms
        @platforms ||= [:all]
      end

      #######################################################################
      ### Observer execution/runtime
      #######################################################################

      def execute
      end
    end
  end
end
