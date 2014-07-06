##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf/message'

module Blick
  module Events

    ##
    # Enum Classes
    #
    class SourceTypes < ::Protobuf::Enum
      define :COUNTER, 9001
      define :SNAPSHOT, 9002
    end


    ##
    # Message Classes
    #
    class Header < ::Protobuf::Message; end
    class Heartbeat < ::Protobuf::Message; end
    class Datapoint < ::Protobuf::Message; end


    ##
    # Message Fields
    #
    class Header
      required :string, :hostname, 1
      required :string, :timestamp, 2
    end

    class Heartbeat
      required ::Blick::Events::Header, :header, 1
      repeated :string, :observers, 2
      repeated :string, :listeners, 3
    end

    class Datapoint
      required ::Blick::Events::Header, :header, 1
      required :string, :name, 2
      required :string, :value, 3
      required ::Blick::Events::SourceTypes, :source_type, 4
      required :string, :emitter, 5
    end

  end

end

