# frozen_string_literal: true

require_relative 'directory/actions'
require_relative 'directory/delegates'
require_relative 'directory/handler'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        class Emulated < Device::Emulated
          # Device::Telephone::Emulated::Directory
          module Directory
            include Handler
            include Delegates
            include Actions
          end
        end
      end
    end
  end
end
