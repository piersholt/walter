# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      # ID: DECIMAL? HEX?
      class OBCDisplay < Base
        # Arguments Map
        # 0: Mode
        # 1: Control
        # 2+: Text

        attr_accessor :mode, :control, :text, :chars

        def initialize(id, props)
          super(id, props)

          # @arguments = props[:arguments]
          @argument_map = map_byte_stream(@arguments)

          @mode = parse_mode(@argument_map[:mode])
          @control = parse_control(@argument_map[:control])
          @text = parse_chars(@argument_map[:chars])
        end

        # def to_s
        #   if @verbose
        #     puts @chars.overlay
        #     "#{@short_name} (#{d})\t [#{@arguments.map(&:h).join(' ')}]"
        #   else
        #     "#{@short_name}\t#{@mode} \"#{@text}\""
        #   end
        # end

        def inspect
          str_buffer = "#{sn}\t#{sprintf("%-10s", mode)}\t\"#{text}\""
          str_buffer
        end


        private

        def map_byte_stream(arguments)
          { mode: arguments[0],
            control: arguments[1],
            chars: arguments[2..-1] }
          end

          def parse_mode(mode_byte)
            mode_value = mode_byte.to_d
            @modes[mode_value]
          end

          def parse_control(control_byte)
            control_value = control_byte.to_d
          end

          def parse_chars(arguments)
            Chars.new(arguments)
          end
        end
      end
  end
end