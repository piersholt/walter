# frozen_string_literal: true

module Messaging
  # Base Message validation
  module Validation
    include Constants

    def validate_topic(topic)
      raise ArgumentError, "Invalid Topic: #{topic}. (#{TOPICS})" unless valid_topic?(topic)
    end

    def validate_type(type)
      raise ArgumentError, "Invalid Type: #{type}. (#{TYPES})" unless valid_type?(type)
    end

    def validate_version(version)
      raise ArgumentError, "Invalid Version: #{version}." unless valid_version?(version)
    end

    private

    def valid_version?(version)
      return false unless version.is_a?(Integer)
      return false unless version.nonzero?
      true
    end

    def valid_topic?(topic)
      TOPICS.one? { |t| t == topic }
    end

    def valid_type?(type)
      TYPES.one? { |t| t == type }
    end
  end
end
