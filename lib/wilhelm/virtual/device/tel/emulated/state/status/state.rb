# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module State
            module Status
              # Device::Telephone::Emulated::State::Status::State
              module State
                include Constants

                def bit1?
                  case state[STATE_STATUS][STATUS_BIT_1]
                  when STATUS_OFF
                    false
                  when STATUS_ON
                    true
                  end
                end

                def bit2?
                  case state[STATE_STATUS][STATUS_BIT_2]
                  when STATUS_OFF
                    false
                  when STATUS_ON
                    true
                  end
                end

                def active?
                  case state[STATE_STATUS][STATUS_ACTIVE]
                  when STATUS_OFF
                    false
                  when STATUS_ON
                    true
                  end
                end

                def power?
                  case state[STATE_STATUS][STATUS_POWER]
                  when STATUS_OFF
                    false
                  when STATUS_ON
                    true
                  end
                end

                def display?
                  case state[STATE_STATUS][STATUS_DISPLAY]
                  when STATUS_OFF
                    false
                  when STATUS_ON
                    true
                  end
                end

                def incoming?
                  case state[STATE_STATUS][STATUS_INCOMING]
                  when STATUS_OFF
                    false
                  when STATUS_ON
                    true
                  end
                end

                def menu?
                  case state[STATE_STATUS][STATUS_MENU]
                  when STATUS_OFF
                    false
                  when STATUS_ON
                    true
                  end
                end

                def hfs?
                  case state[STATE_STATUS][STATUS_HFS]
                  when STATUS_OFF
                    false
                  when STATUS_ON
                    true
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
