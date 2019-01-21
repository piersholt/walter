# frozen_string_literal: false

class Command
  # Command 0x38
  class CDChangerRequest < ParameterizedCommand

    CONTROL_MAP = {
      0x00 => :status,
      0x01 => :stop,
      0x02 => :resume,
      0x03 => :play,
      0x04 => :scan,
      0x05 => :seek,
      0x06 => :change_disc,
      0x07 => :mode_scan,
      0x08 => :mode_random,
      0x0A => :change_track
    }.freeze

    def name
      'CD Changer Request'
    end

    def controls
      CONTROL_MAP.vaues
    end

    def is?(control_symbol)
      control? == control_symbol
    end

    def status?
      is?(:status)
    end

    def stop?
      is?(:stop)
    end

    def resume?
      is?(:resume)
    end

    def play?
      is?(:play)
    end

    def scan?
      is?(:scan)
    end

    def seek?
      is?(:seek)
    end

    def change_disc?
      is?(:change_disc)
    end

    def mode_scan?
      is?(:mode_scan)
    end

    def mode_random?
      is?(:mode_random)
    end

    def change_track?
      is?(:change_track)
    end

    def mode?
      !mode.value.zero?
    end

    def control?
      case control.value
      when 0x00
        :status
      when 0x01
        :stop
      when 0x02
        :resume
      when 0x03
        :play
      when 0x04
        :scan
      when 0x05
        :seek
      when 0x06
        :change_disc
      when 0x07
        :mode_scan
      when 0x08
        :mode_random
      when 0x0A
        :change_track
      else
        raise StandardError, "Unknown control value?! #{control.value}"
      end
    end
  end
end
