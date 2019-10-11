# frozen_string_literal: true

require_relative 'status/state'
require_relative 'status/modifiers'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module State
            # Telephone::Emulated::Status
            module Status
              include State
              include Modifiers

              # 2: On Call
              def active!
                active.status!
              end

              def inactive!
                inactive.status!
              end

              # 3: Power
              def on!
                on.status!
              end

              def off!
                off.status!
              end

              # 5: Incoming
              def incoming!
                incoming.status!
              end

              def no_friends!
                no_friends.status!
              end

              # 6: Menu

              def menu!
                menu(1).status!
              end

              # 7: Handsfree/Handset
              def handset!
                handset.status!
              end

              def handsfree!
                handsfree.status!
              end

              # API
              def status_bit_field
                i = 0

                i |= 1 << STATUS_SHIFT_BIT_0    if bit0?
                i |= 1 << STATUS_SHIFT_BIT_1    if bit1?
                i |= 1 << STATUS_SHIFT_ACTIVE   if active?
                i |= 1 << STATUS_SHIFT_POWER    if power?

                i |= 1 << STATUS_SHIFT_DISPLAY  if display?
                i |= 1 << STATUS_SHIFT_INCOMING if incoming?
                i |= 1 << STATUS_SHIFT_MENU     if menu?
                i |= 1 << STATUS_SHIFT_HFS      if hfs?

                i
              end
            end
          end
        end
      end
    end
  end
end
