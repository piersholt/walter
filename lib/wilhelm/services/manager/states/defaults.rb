# frozen_string_literal: false

require_relative 'defaults/actions'
require_relative 'defaults/notifications'
require_relative 'defaults/states'

module Wilhelm
  module Services
    class Manager
      # Manager::Defaults
      module Defaults
        include States
        include Actions
        include Notifications
      end
    end
  end
end
