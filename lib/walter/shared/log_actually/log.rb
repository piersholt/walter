# frozen_string_literal: true

require 'logger'
require 'forwardable'

class LogActually
  # Comment
  class Log
    include Formatter
    extend Forwardable
    include Constants

    def_delegators :logger, *Logger.instance_methods(false)

    attr_accessor :logger
    attr_reader :id

    def initialize(id, stream = STDERR)
      @id = id
      @logger = Logger.new(stream)
      logger.formatter = default_formatter
      logger.sev_threshold = DEFAULT_LEVEL
    end

    def d
      logger.sev_threshold = Logger::DEBUG
    end

    def i
      logger.sev_threshold = Logger::INFO
    end

    def w
      logger.sev_threshold = Logger::WARN
    end

    def e
      logger.sev_threshold = Logger::ERROR
    end

    def f
      logger.sev_threshold = Logger::FATAL
    end
  end
end
