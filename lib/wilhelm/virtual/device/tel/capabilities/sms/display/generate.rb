# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          module SMS
            module Display
              # Telephone::Capabilities::SMS::Generate
              module Generate
                include Wilhelm::Helpers::DataTools
                include Helpers::Data

                private

                def pad_chars(string, required_length)
                  Kernel.format("%-#{required_length}s", string)
                end

                def generate_a5(layout, padding, index, length = 10)
                  "a5 #{d2h(layout)} #{d2h(padding)} #{d2h(index)} #{genc(length)}"
                end

                def generate_21(layout, m2, index, length = 10)
                  "21 #{d2h(layout)} #{d2h(m2)} #{d2h(index)} #{genc(length)}"
                end

                def generate_23(gfx, ike, length = 10)
                  "23 #{d2h(gfx)} #{d2h(ike)} #{genc(length)}"
                end
              end
            end
          end
        end
      end
    end
  end
end
