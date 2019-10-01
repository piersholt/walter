# frozen_string_literal: true

require_relative 'mock/contacts'
require_relative 'mock/history'
require_relative 'mock/messages'

module Wilhelm
  module Services
    class Telephone
      # Telephone::Mock
      module Mock
        include Contacts
        include History
        include Messages
      end
    end
  end
end
