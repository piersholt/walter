# frozen_string_literal: false

# Priority 1
# These defects are immediately indi-
# cated by a gong and a flashing warning symbol (1).
# Simultaneous defects will be displayed consecutively.
# These status reports remain in the display until the defects are corrected.
# It is not pos- sible to delete them by pressing the CHECK button (3):

# CCM	IKE	1A	[54 3]	"     LIGHTS ON      "
# ARROW: 2 (FLASH), GONG: HIGH (DOUBLE)
# POST TRIP

# CCM	IKE	1A	[55 4]	" CHECK BRAKE LIGHTS "
# ARROW: 0, GONG: HIGH
# PRIORIY 2

# CCM	IKE	1A	[55 16]	"   RANGE  24 KM     "
# ARROW: 0: NO, GONG: LOW

# CCM IKE 1A [55 5] "CHECK LOWBEAM LIGHTS"

module Wilhelm
  module Virtual
    class Command
      # ID: 26 0x1A
      class CCMDisplay < BaseCommand
        attr_accessor :mode, :control, :chars

        def initialize(id, props)
          super(id, props)
        end

        def inspect
          # super handles from to command
          # this only appends arguments
          # str_buffer = super
          # TODO: this needs to be a string, not have Chars print itself
          # puts @chars.overlay
          # "[#{@arguments.map(&:h).join(' ')}]"

          str_buffer = sprintf("%-10s", sn)
          # str_buffer = str_buffer.concat("\t#{@mode} #{@control}")
          str_buffer = str_buffer.concat("#{sn}\t#{mode.value} (#{mode.to_s}) | #{control.value} (#{control.to_s})\t#{chars.to_s}")
          # str_buffer = append_chars(str_buffer)
          str_buffer
        end

        def to_s
          str_buffer = "#{sn}\t#{mode.value} (#{mode.to_s}) | #{control.value} (#{control.to_s})\t#{chars.to_s}"
          # str_buffer = append_chars(str_buffer)
          str_buffer
        end
      end
    end
  end
end
