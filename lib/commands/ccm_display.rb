class Commands
  # ID: 26 0x1A
  class CCMDisplay < BaseCommand

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

    attr_accessor :mode, :control, :text

    def initialize(id, props)
      super(id, props)
    end

    def inspect
      # super handles from to command
      # this only appends arguments
      str_buffer = super
      # TODO: this needs to be a string, not have Chars print itself
      # puts @chars.overlay
      # "[#{@arguments.map(&:h).join(' ')}]"

      "#{h}\t#{@argument_map[:mode]} #{@argument_map[:control]}\t\"#{@text}\""
    end

    def to_s
      "#{@short_name}\t#{@mode} | #{@control}\t\"#{@text.to_s}\""
    end

    private

    end
  end
end
