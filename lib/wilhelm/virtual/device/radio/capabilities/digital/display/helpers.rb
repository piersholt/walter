# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module RDS
            module Display
              # RDS::Display::Generate
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

                def generate_23(gt, ike, length = 10)
                  "23 #{d2h(gt)} #{d2h(ike)} #{genc(length)}"
                end
              end
            end
          end
        end
      end
    end
  end
end
