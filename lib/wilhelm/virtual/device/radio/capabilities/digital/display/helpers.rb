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

                def generate_a5(layout, pos, index, length = 10)
                  "a5 #{gens(length)} #{d2h(layout)} #{d2h(pos)} #{d2h(index)}"
                end

                def generate_21(layout, m2, index, length = 10)
                  "21 #{gens(length)} #{d2h(layout)} #{d2h(m2)} #{d2h(index)}"
                end

                def generate_23(gt, ike, length = 10)
                  "23 #{d2h(gt)} #{d2h(ike)} #{gens(length)}"
                end
              end
            end
          end
        end
      end
    end
  end
end
