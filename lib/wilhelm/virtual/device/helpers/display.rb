# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Helpers
        # Telephone::Capabilities::SMS::Generate
        module Display
          include Wilhelm::Helpers::DataTools
          include Helpers::Data

          private

          def pad_chars(string, required_length)
            Kernel.format("%-#{required_length}s", string)
          end

          def generate_a5(layout, padding, index, length = 10)
            "a5 #{d2h(layout)} #{d2h(padding)} #{d2h(index)} #{gens(length)}"
          end

          alias g_a5 generate_a5

          def generate_21(layout, m2, index, length = 10)
            "21 #{d2h(layout)} #{d2h(m2)} #{d2h(index)} #{gens(length)}"
          end

          def format_21(layout, m2, index, suffix)
            "21 #{d2h(layout)} #{d2h(m2)} #{d2h(index)} #{suffix}"
          end

          def format_31(layout, m2, index)
            "31 #{d2h(layout)} #{d2h(m2)} #{d2h(index)}"
          end

          def format_a5(layout, m2, index, suffix)
            "a5 #{d2h(layout)} #{d2h(m2)} #{d2h(index)} #{suffix}"
          end

          def generate_23(gt, ike, length = 10)
            "23 #{d2h(gt)} #{d2h(ike)} #{gens(length)}"
          end
        end
      end
    end
  end
end
