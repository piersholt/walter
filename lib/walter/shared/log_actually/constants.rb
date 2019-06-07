# frozen_string_literal: true

class LogActually
  module Constants
    RESET = '0'.freeze
    LIGHT_GRAY = '37'.freeze
    GREEN = '32'.freeze
    YELLOW = '33'.freeze
    RED = '31'.freeze
    MAGENTA = '35'.freeze

    DEFAULT_LEVEL = Logger::INFO

    SEVERITY_TO_COLOUR_MAP = {
      'DEBUG' => :gray,
      'INFO' => :green,
      'WARN' => :yellow,
      'ERROR' => :red,
      'FATAL' => :red,
      'UNKNOWN' => :magenta,
      'ANY' => :magenta
    }.freeze

    MOI = 'LogActually'.freeze
  end
end
