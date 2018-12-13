class Command
  class Monitor < BaseCommand

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
      str_buffer = "#{sn}\tAction: #{action} (#{dictionary(:action)}), Nav: #{nav} (#{dictionary(:nav)})"
      str_buffer
    end

    # def inspect
    #   "#<#{self.class} @key=#{key} (#{dict(:key, key)}) @status=#{status} (#{dict(:status, status)})>"
    # end
  end
end
