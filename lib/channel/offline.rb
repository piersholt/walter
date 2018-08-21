require 'forwardable'

class Channel
  # The binary stream stored as a local file for offline processing
  class Offline
    extend Forwardable

    def_delegators :stream, :pos, :readpartial

    attr_reader :stream

    DEFAULT_OPTIONS = { mode: 'rb' }.freeze

    def initialize(path, options = DEFAULT_OPTIONS)
      @stream = ::File.open(path, options[:mode])
      # @stream = ::ARGF
    end
  end
end
