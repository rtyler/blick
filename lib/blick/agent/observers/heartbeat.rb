require 'blick/agent/observer'
require 'blick/events'
require 'blick/emitter'

module Blick::Agent
  module Observers
    # The heartbeat observer is for indicating that this instance of the agent
    # is operational and functioning properly.
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

      # Emit a {Blick::Events::Heartbeat} event to the bus
      #
      # @return [Boolean] Success of the +#emit+ operation
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
