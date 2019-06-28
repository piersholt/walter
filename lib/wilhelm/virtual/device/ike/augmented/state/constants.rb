# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module IKE
        class Augmented < Device::Augmented
          module State
            # Radio related command constants
            module Constants
              ZERO = 0b0000_0000
              OFF = :off
              ON = :on

              # BYTE 1

              MEMO = {
                off: ZERO,
                on: 0b0010_0000
              }.freeze

              TIMER = {
                off: ZERO,
                on: 0b0000_1000
              }.freeze

              LIMIT = {
                off: ZERO,
                on: 0b0000_0010
              }.freeze

              # BYTE 2

              CODE = {
                off: ZERO,
                on: 0b0100_0000
              }.freeze

              AUX_LED_FLASH = {
                off: ZERO,
                on: 0b0010_0000
              }.freeze

              AUX_TIMER_2 = {
                off: ZERO,
                on: 0b0001_0000
              }.freeze

              AUX_DIRECT = {
                off: ZERO,
                on: 0b0000_1000
              }.freeze

              AUX_TIMER_1 = {
                off: ZERO,
                on: 0b0000_0100
              }.freeze
            end
          end
        end
      end
    end
  end
end
