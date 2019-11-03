# frozen_string_literal: false

require_relative 'radio/coding'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        module Capabilities
          # Diagnostics::Capabilities::Radio
          module Radio
            include Coding
          end
        end
      end
    end
  end
end
