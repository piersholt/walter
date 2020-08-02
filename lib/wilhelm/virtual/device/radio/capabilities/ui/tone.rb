# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module UserInterface
            # Radio::Capabilities::UserInterface::Tone
            module Tone
              include Constants
              include API

              def tone_set(
                  bass    = Random.rand(0x1f),
                  treble  = Random.rand(0x1f),
                  fader   = Random.rand(0x1f),
                  balance = Random.rand(0x1f)
                )
                rad_37(mode: TONE_SET | bass, opts: [treble, fader, balance])
              end

              # 0xc0
              def tone_bass
                rad_37(mode: TONE_EDIT | TONE_BASS)
              end

              # 0xd0
              def tone_treble
                rad_37(mode: TONE_EDIT | TONE_TREBLE)
              end

              # 0xe0
              def tone_fader
                rad_37(mode: TONE_EDIT | TONE_FADER)
              end

              # 0xf0
              def tone_balance
                rad_37(mode: TONE_EDIT | TONE_BALANCE)
              end
            end
          end
        end
      end
    end
  end
end
