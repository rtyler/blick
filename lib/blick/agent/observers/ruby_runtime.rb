require 'blick/agent/observer'
require 'blick/events'
require 'blick/emitter'

module Blick::Agent
  module Observers
    class RubyRuntime < Observer
      def self.name
        'Blick Runtime Stats'
      end

      def self.description
        'Collection of metrics relating to the Blick Ruby runtime'
      end

      def self.enabled?
        true
      end

      def self.interval
        30
      end

      def self.platforms
        [].freeze
      end

      def execute
        # XXX: need to implement processing of GC#stat here
        Blick::Emitter.emit(nil)
      end
    end
  end
end
