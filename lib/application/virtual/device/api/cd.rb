# frozen_string_literal: true

# require 'application/virtual/api/base_api'

module API
  # API for command related to keys
  module CD
    include BaseAPI

    PROC = 'API CD'

    REQUEST = {
      id:   0x38,
      to:   :cdc,
      from: :rad
    }.freeze

    STATUS = {
      id:   0x39,
      to:   :rad,
      from: :cdc
    }.freeze

    # @param loader: Number of CD loaded into changer
    # @param cd: Current CD number
    # @param track: Current Track number
    def changer(command_arguments, from_id = STATUS[:from], to_id = STATUS[:to])
      # LOGGER.warn(PROC) { (command_arguments) }
      command_id = STATUS[:id]
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end
  end
end