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
      str_buffer = "#{sn}\t#{key}: #{status}"
      str_buffer
    end

    def inspect
      "#<#{self.class} @key=#{key} (#{dictionary(:key)}) @status=#{status} (#{dictionary(:status)})>"
    end
  end
end
