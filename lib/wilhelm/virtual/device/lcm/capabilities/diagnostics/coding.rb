# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module LCM
        module Capabilities
          module Diagnostics
            # LCM::Capabilities::Diagnostics::Coding
            module Coding
              include API

              CODING = [
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x74,
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                0x00, 0x4e, 0x40, 0x90, 0x00, 0x00, 0x01, 0x00,
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
              ].freeze

              def coding
                @coding ||= CODING.dup
              end

              def coding=(*args)
                @coding = args
              end

              def coding!(data = coding)
                a0(arguments: data)
              end
            end
          end
        end
      end
    end
  end
end
