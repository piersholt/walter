# frozen_string_literal: false

require_relative 'auxiliary/direct'
require_relative 'auxiliary/timer'

module Wilhelm
  module Virtual
    class Device
      module GT
        module Capabilities
          # Auxiliary Ventilation Control
          module AuxiliaryVentilation
            include Direct
            include Timer
          end
        end
      end
    end
  end
end
