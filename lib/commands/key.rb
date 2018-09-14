class Commands
  # ID: 25 0x19
  class Key < BaseCommand
    attr_accessor :v1, :v2

    # SPEED_UNIT = 'kmph'.freeze
    # REV_UNIT = 'rpm'.freeze

    def initialize(id, props)
      super(id, props)
    end

    # ---- Interface ---- #

    def ambient
      @v1
    end

    def coolant
      @v2
    end

    # ---- Printable ---- #

    def bytes
      @bytes ||= {}
    end

    # ---- Core ---- #

    # @override
    def to_s
      # speed = "#{v1}#{SPEED_UNIT}"
      # rev = "#{v2}#{REV_UNIT}"

      str_buffer = "#{sn}\t#{dict(:key, key)}: #{dict(:status, status)}"
      str_buffer
    end

    private

  end
end
