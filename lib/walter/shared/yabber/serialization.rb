# frozen_string_literal: true

module Messaging
  # Comment
  module Serialization
    include Constants
    include Klasses
    include ObjectValidation

    def parse_object(serialized_object, format)
      deserialized_object = deserialize(serialized_object, format)
      validate_object(deserialized_object)
      deserialized_object
    end

    def deserialize(object, format)
      case format
      when :yaml
        YAML.load(object)
      when :json
        JSON.parse(object)
      end
    rescue TypeError => e
      LogActually.messaging.error(self.class) { e }
      LogActually.messaging.error(self.class) { "object: #{object}" }
      LogActually.messaging.error(self.class) { "format: #{format}" }
    end
  end
end
