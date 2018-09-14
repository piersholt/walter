class Commands
  class Key < BaseCommand

    def initialize(id, props)
      super(id, props)
    end

    # ---- Printable ---- #

    def bytes
      @bytes ||= {}
    end

    # ---- Core ---- #

    # @override
    def to_s
      str_buffer = "#{sn}\t#{dict(:key, key)}: #{dict(:status, status)}"
      str_buffer
    end

    def inspect
      "#<#{self.class} @key=#{key} (#{dict(:key, key)}) @status=#{status} (#{dict(:status, status)})>"
    end
  end
end
