# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module CDChanger
            # CD Changer Playback Control
            module Playback
              include API
              include Constants

              def status!
                cd_changer_request(control: CONTROL_STATUS, mode: 0x00)
              end

              def stop!
                cd_changer_request(control: CONTROL_STOP, mode: 0x00)
              end

              def play!
                cd_changer_request(control: CONTROL_PLAY, mode: 0x00)
              end

              def fwd!
                cd_changer_request(control: CONTROL_SCAN, mode: 0x00)
                Kernel.sleep(2)
                play!
              end

              def rwd!
                cd_changer_request(control: CONTROL_SCAN, mode: 0x01)
                Kernel.sleep(2)
                play!
              end

              def next!
                cd_changer_request(control: CONTROL_SEEK, mode: 0x00)
              end

              def previous!
                cd_changer_request(control: CONTROL_SEEK, mode: 0x01)
              end

              def change_disc!(disc)
                cd_changer_request(control: CONTROL_CHANGE_DISC, mode: disc)
              end
            end
          end
        end
      end
    end
  end
end
