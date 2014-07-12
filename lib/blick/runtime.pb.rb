##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf/message'


##
# Imports
#
require 'events.pb'

module Blick
  module Events
    module Datapoints

      ##
      # Message Classes
      #
      class RubyRuntime < ::Protobuf::Message; end


      ##
      # Message Fields
      #
      class RubyRuntime
        required ::Blick::Events::Header, :header, 1
        required :string, :name, 2
        required :string, :value, 3
        required ::Blick::Events::SourceTypes, :source_type, 4
        required :string, :emitter, 5
      end

    end

  end

end

