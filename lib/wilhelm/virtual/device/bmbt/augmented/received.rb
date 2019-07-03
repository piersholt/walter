# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module BMBT
        class Augmented < Device::Augmented
          # BMBT::Augmented::Received
          module Received
            def handle_rad_led(command)
              case command.led?
              when :on
                on!
              when :radio
                on!
              when :tape
                on!
              when :reset
                off!
              when :off
                off!
              end
            end

            private

            # TODO should be state...
            def on!
              @power = true
            end

            def off!
              @power = false
            end

            def power?
              @power ||= false
            end
          end
        end
      end
    end
  end
end
