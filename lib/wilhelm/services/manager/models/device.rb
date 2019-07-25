# frozen_string_literal: true

require_relative 'device/constants'
require_relative 'device/actions'
require_relative 'device/attributes'
require_relative 'device/notifications'

module Wilhelm
  module Services
    class Manager
      # Manager::Device
      class Device
        include Observable
        include Attributes
        include Notifications
        include Actions
        include Helpers::Object

        def initialize(attributes)
          @attributes = attributes
        end

        def path
          attributes[:path]
        end

        alias id path

        def self.parse_device_path(path_string)
          matches = path_string.match(%r{[0-9A-F]{2,2}_[0-9A-F_]+\Z})
          raise StandardError, 'Many matches!' if matches.length > 1
          camel_path = matches.to_s
          camel_path.split('_').join(':')
        end
      end
    end
  end
end
