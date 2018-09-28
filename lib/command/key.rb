class Command
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
      "#<#{self.class} @key=#{key.value} (#{key.to_s}) @status=#{status.value} (#{status.to_s})>"
    end
  end
end
