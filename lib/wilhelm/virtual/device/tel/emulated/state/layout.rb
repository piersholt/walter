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
              def smses!
                @layout = :smses
              end

              def smses?
                layout == :smses
              end

              # 0xf1
              def sms!
                @layout = :sms
              end

              def sms?
                layout == :sms
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
