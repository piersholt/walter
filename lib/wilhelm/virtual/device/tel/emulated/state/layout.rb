# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          module State
            # Telephone::Emulated::State::Layout
            module Layout
              def layout
                @layout ||= :background
              end

              # BMBT Main Menu
              def background!
                logger.warn(PROC) { 'Menu pressed! @layout -> :background' }
                @layout = :background
              end

              def background?
                layout == :background
              end

              # 0x00
              def default!
                @layout = :default
              end

              def default?
                layout == default
              end

              # 0x05
              def pin!
                @layout = :pin
              end

              def pin?
                layout == :pin
              end

              # 0x20
              def info!
                @layout = :info
              end

              def info?
                layout == :info
              end

              # 0x42
              def dial!
                @layout = :dial
              end

              def dial?
                layout == :dial
              end

              def last_numbers!
                @layout = :last_numbers
              end

              def last_numbers?
                layout == :last_numbers
              end

              # 0x43
              def directory!
                @layout = :directory
              end

              def directory?
                layout == :directory
              end

              # 0x80
              def top_8!
                @layout = :top_8
              end

              def top_8?
                layout == :top_8
              end

              # 0xf0
              def sms_index!
                @layout = :sms_index
              end

              def sms_index?
                layout == :sms_index
              end

              # 0xf1
              def sms_show!
                @layout = :sms_show
              end

              def sms_show?
                layout == :sms_show
              end

              # 0xf1
              def sos!
                @layout = :sos
              end

              def sos?
                layout == :sos
              end
            end
          end
        end
      end
    end
  end
end
