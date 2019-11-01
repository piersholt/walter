# frozen_string_literal: true

require_relative 'state/constants'
require_relative 'state/model'
require_relative 'state/config'
require_relative 'state/ignition'

module Wilhelm
  module Virtual
    class Device
      module IKE
        class Augmented < Device::Augmented
          # IKE::Augmented::State
          module State
            include Model
            include Config
            include Ignition
          end
        end
      end
    end
  end
end
