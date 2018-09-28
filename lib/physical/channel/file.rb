require 'forwardable'

class Channel
  # The binary stream stored as a local file for offline processing
  class File
    extend Forwardable

    def_delegators :stream, :pos, :readpartial

    attr_reader :stream

    DEFAULT_OPTIONS = { mode: 'rb' }.freeze

    def initialize(path, options = DEFAULT_OPTIONS)
      @stream = ::File.open(path, options[:mode])
      # @stream = ::ARGF
    end

    def write(args = nil)
      raise TransmissionError, 'Device is log file. Cannot write to bus.'
    end
  end
end
