# frozen_string_literal: true

puts "\tLoading wilhelm/virtual/device/helpers"

require_relative 'helpers/cluster'
require_relative 'helpers/data'
require_relative 'helpers/button'

module Wilhelm
  module Virtual
    class Device
      # Comment
      module Helpers
        def self.included(mod)
          LOGGER.debug('Debug') { "#{mod} is including #{self.name}" }
        end
      end
    end
  end
end
