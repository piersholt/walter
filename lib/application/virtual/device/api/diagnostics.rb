# frozen_string_literal: true

# require 'application/virtual/api/base_api'

module API
  # API for command related to keys
  module Diagnostics
    include BaseAPI

    def vehicle_control(from: me, to:, arguments:)
      try(from, to, 0x0C, arguments)
    end
  end
end
