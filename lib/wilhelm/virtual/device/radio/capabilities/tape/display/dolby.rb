# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module Tape
            # Radio::Capabilities::Tape::Dolby
            module Display
              module Dolby
                include API
                include Constants

                DEFAULT_DOLBY = :b

                DOLBY_MASK = {
                  off:  0b000 << 0,
                  b:    0b001 << 0,
                  c:    0b010 << 0
                }.freeze

                DOLBY_DICT = {
                  off:  " B \xCD\x05\xCE C \x05",
                  b:    "*B \xCD\x05\xCE C \xA7",
                  c:    " B \xCD\x05\xCE C*\x05"
                }.freeze


                def dolby(type = DEFAULT_DOLBY)
                  draw_21(
                    layout: SOURCE_TAPE | TAPE_SIDE_DOLBY,
                    m2: DOLBY_MASK.fetch(type, DOLBY_MASK[DEFAULT_DOLBY]),
                    m3: INDEX_DOLBY,
                    chars: DOLBY_DICT.fetch(type, DOLBY_DICT[DEFAULT_DOLBY])
                  )
                end
              end
            end
          end
        end
      end
    end
  end
end
