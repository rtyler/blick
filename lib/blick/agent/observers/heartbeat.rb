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

      def self.enabled?
        true
      end

      # @return [Fixnum] number of seconds to run this observer
      def self.interval
        10
      end

      def self.platforms
        @platforms ||= [:all]
      end

      #######################################################################
      ### Observer execution/runtime
      #######################################################################

      def execute
        beat = Blick::Events::Heartbeat.new(:header => Blick::Events.header)
        beat.observers = self.enabled_observers
        return Blick::Emitter.emit(beat)
      end

      # @return [Array] Collection of the names of the currently enabled
      #   observers
      def enabled_observers
        Blick::Agent::Observer.registry.map { |obs|
          if obs.enabled?
            obs.name
          else
            nil
          end
        }.compact
      end
    end
  end
end
