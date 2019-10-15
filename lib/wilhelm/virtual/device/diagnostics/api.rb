# frozen_string_literal: true

require_relative 'api/activate'
require_relative 'api/coding'
require_relative 'api/info'
require_relative 'api/memory'

module Wilhelm
  module Virtual
    class Device
      module Diagnostics
        # API for command related to keys
        module API
          include Device::API::BaseAPI
          include Info
          include Coding
          include Memory
          include Activate
        end
      end
    end
  end
end
