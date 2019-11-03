# frozen_string_literal: true

require_relative 'controls/bt'
require_relative 'controls/soft'

module Wilhelm
  module Virtual
    class Device
      module BMBT
        module Capabilities
          # BMBT::Capabilities::UserControls
          module UserControls
            include BT
            include Soft
          end
        end
      end
    end
  end
end
