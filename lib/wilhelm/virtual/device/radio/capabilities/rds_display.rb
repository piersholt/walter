# frozen_string_literal: true

require_relative 'rds_display/header'
require_relative 'rds_display/menu'
require_relative 'rds_display/quick'

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          # RDS Display
          module RDSDisplay
            include API
            include Constants
            include Wilhelm::Helpers::DataTools
            include Header
            include Menu
            include Quick

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
