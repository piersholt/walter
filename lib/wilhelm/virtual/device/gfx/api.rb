# frozen_string_literal: true

require_relative 'api/radio'
require_relative 'api/settings'
require_relative 'api/telephone'

module Wilhelm
  module Virtual
    class Device
      module GFX
        # Top level GFX API
        module API
          include Radio
          include Settings
          include Telephone
        end
      end
    end
  end
end
