# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      class RadioLED < BaseCommand

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
          str_buffer = "#{sn}\tLED: #{led}"
          str_buffer
        end

        def inspect
          "#<#{self.class} @led=#{led.value} (#{led})>"
        end

        def tape?
          led? == :tape
        end

        def off?
          led? == :off
        end

        def radio?
          led? == :radio
        end

        def on?
          led? == :on
        end

        def led?
          case led.value
          when (0x40..0x45)
            :tape
          when 0x48
            :radio
          when 0x00
            :off
          when (0x5a..0x5f)
            :tape
          when 0x90
            :reset
          when 0xff
            :on
          end
        end
      end
    end
  end
end
