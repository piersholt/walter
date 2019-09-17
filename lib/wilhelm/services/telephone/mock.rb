# frozen_string_literal: true

require_relative 'mock/contacts'
require_relative 'mock/dial'
require_relative 'mock/directory'
require_relative 'mock/info'
require_relative 'mock/pin'
require_relative 'mock/quick'
require_relative 'mock/sms'
require_relative 'mock/sos'
require_relative 'mock/top_8'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Telephone::Capabilities::Mock
          module Mock
            # include Dial
            # include Directory
            # include Info
            # include PIN
            # include Quick
            # include Top8
            # include SMS
            # include SOS
          end
        end
      end
    end
  end
end
