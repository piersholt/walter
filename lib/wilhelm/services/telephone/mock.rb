# frozen_string_literal: true

require_relative 'mock/contacts'
require_relative 'mock/messages'

module Wilhelm
  module Services
    # Bluetooth Telephone
    class Telephone
      include Contacts
      include Messages
    end
  end
end
