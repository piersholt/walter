# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module State
            module Status
              # Device::Telephone::Emulated::State::Status::Modifiers
              module Modifiers
                include Constants

                # Status Bit 1 Unknown

                def bit1_0
                  state!(STATE_STATUS => { STATUS_BIT_1 => STATUS_NO })
                  self
                end

                def bit1_1
                  state!(STATE_STATUS => { STATUS_BIT_1 => STATUS_YES })
                  self
                end

                # Status Bit 2 Unknown

                def bit2_0
                  state!(STATE_STATUS => { STATUS_BIT_2 => STATUS_NO })
                  self
                end

                def bit2_1
                  state!(STATE_STATUS => { STATUS_BIT_2 => STATUS_YES })
                  self
                end

                # Status Bit 2 In use/Active

                def inactive
                  state!(STATE_STATUS => { STATUS_ACTIVE => STATUS_NO })
                  self
                end

                def active
                  state!(STATE_STATUS => { STATUS_ACTIVE => STATUS_YES })
                  self
                end

                # Status Bit 3 Power

                def off
                  state!(STATE_STATUS => { STATUS_POWER => STATUS_OFF })
                  self
                end

                def on
                  state!(STATE_STATUS => { STATUS_POWER => STATUS_ON })
                  self
                end

                def power(state)
                  raise(ArgumentError, 'Invalid Power State') unless POWER_STATES.include?(state)
                  state!(STATE_STATUS => { STATUS_POWER => state })
                  self
                end

                # Status Bit 4 Display

                def display(state = STATUS_OFF)
                  state!(STATE_STATUS => { STATUS_DISPLAY => state })
                  self
                end

                # Status Bit 5 Incoming

                def no_friends
                  state!(STATE_STATUS => { STATUS_INCOMING => STATUS_NO })
                  self
                end

                def incoming
                  state!(STATE_STATUS => { STATUS_INCOMING => STATUS_YES })
                  self
                end

                # Status Bit 6 Menu

                def menu(state = STATUS_OFF)
                  state!(STATE_STATUS => { STATUS_MENU => state })
                  self
                end

                # Status Bit 7 Handsfree

                def handset
                  state!(STATE_STATUS => { STATUS_HFS => STATUS_OFF })
                  self
                end

                def handsfree
                  state!(STATE_STATUS => { STATUS_HFS => STATUS_ON })
                  self
                end

                # API

                def status_bit_array
                  i = 0
                  i += 0b1 << STATUS_SHIFT_BIT_1 if bit1?
                  i += 0b1 << STATUS_SHIFT_BIT_2 if bit2?
                  i += 0b1 << STATUS_SHIFT_ACTIVE if active?
                  i += 0b1 << STATUS_SHIFT_POWER if power?
                  i += 0b1 << STATUS_SHIFT_DISPLAY if display?
                  i += 0b1 << STATUS_SHIFT_INCOMING if incoming?
                  i += 0b1 << STATUS_SHIFT_MENU if menu?
                  i += 0b1 << STATUS_SHIFT_HFS if hfs?
                  i
                end

                def status!
                  set_status(status_bit_array)
                end
              end
            end
          end
        end
      end
    end
  end
end
