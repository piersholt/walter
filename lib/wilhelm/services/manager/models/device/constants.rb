# frozen_string_literal: true

module Wilhelm
  module Services
    class Manager
      class Device
        # Manager::Device::Constants
        module Constants
          CONNECTED = 'Connected'.to_sym.downcase
          PAIRED = 'Paired'.to_sym.downcase
          NAME = 'Name'.to_sym.downcase
          ADDRESS = 'Address'.to_sym.downcase
          KLASS = 'Class'.to_sym.downcase
          UUIDS = 'UUIDs'.to_sym.downcase
          TRUSTED = 'Trusted'.to_sym.downcase
          BLOCKED = 'Blocked'.to_sym.downcase
          ALIAS = 'Alias'.to_sym.downcase
          ADAPTER = 'Adapter'.to_sym.downcase
          ICON = 'Icon'.to_sym.downcase
        end
      end
    end
  end
end
