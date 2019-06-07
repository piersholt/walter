# frozen_string_literal: true

module Messaging
  # Comment
  module ObjectValidation
    include Validation

    def validate_object(object)
      validate_hash(object)
      node?(object)
      type?(object)
      topic?(object)
      version?(object)
    end

    def validate_hash(object)
      raise EncodingError, 'Not a hash!' unless valid_hash?(object)
    end

    def valid_hash?(object)
      object.is_a?(Hash)
    end

    def version?(object)
      object.key?(:version)
    end

    def topic?(object)
      object.key?(:topic)
    end

    def type?(object)
      object.key?(:type)
    end

    def node?(object)
      object.key?(:node)
    end
  end
end
