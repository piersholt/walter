# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module LCM
        module Capabilities
          module Diagnostics
            # LCM::Capabilities::Diagnostics::Info
            module Info
              include API

              INFO = [
                0x06, 0x90, 0x84, 0x65, 0x02, 0x18, 0x13, 0x00, 0x07, 0x01, 0x09, 0x42
              ].freeze

              def info
                @info ||= INFO.dup
              end

              def info=(*args)
                @info = args
              end

              def info!(data = info)
                a0(arguments: data)
              end
            end
          end
        end
      end
    end
  end
end
