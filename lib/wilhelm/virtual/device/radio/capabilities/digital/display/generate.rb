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

                def generate_a5(layout, index)
                  "a5 #{d2h(layout)} #{d2h(index)} #{genc(20)}"
                end

                def generate_21(layout, index)
                  "21 #{d2h(layout)} #{d2h(index)} #{genc(20)}"
                end
              end
            end
          end
        end
      end
    end
  end
end
