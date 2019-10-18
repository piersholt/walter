# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module GT
        module Capabilities
          # Device::GT
          module UserInterface
            include API

            # Shortcuts
            def main
              config(arguments: { config: 0b0000_0001 })
            end

            def overlay
              config(arguments: { config: 0b0000_0011 })
            end

            # DIRECT API ---------

            def source(source = 0x10, b2 = 0x00)
              sound_source(arguments: { source: source, b2: b2 })
            end
          end
        end
      end
    end
  end
end
