# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      # Virtual::Command::MediaDisplay
      class MediaDisplay < Base
        attr_accessor :text, :chars, :gfx, :ike

        def inspect
          "#{h}\t" \
          "#{d2h @gfx.value} " \
          "#{d2h @ike.value}\t" \
          "#{@chars}"
        end

        def to_s
          "#{sn}\t" \
          "#{@gfx} | " \
          "#{@ike}\t" \
          "#{@chars}"
        end

        private

        def map_byte_stream(arguments)
          {
            gfx: arguments[0],
            ike: arguments[1],
            text: arguments[2..-1]
          }
        end

        def parse_gfx(variant_byte)
          sub_command_value = variant_byte.d
          human = @gfx[sub_command_value]
          human.nil? ? variant_byte.h : human
        end

        def parse_ike(variant_byte)
          sub_command_value = variant_byte.d
          human = @ike[sub_command_value]
          human.nil? ? variant_byte.h : human
        end

        def parse_text(arguments)
          Chars.new(arguments)
        end
      end
    end
  end
end
