# frozen_string_literal: true

require 'api/base_api'

module API
  # API for telephone related commands
  module Telephone
    include BaseAPI

    LED = {
      id:   0x2B,
      to:   :anzv,
      from: :tel
    }.freeze

    # @param state: Number of CD loaded into changer
    def led(command_arguments, from_id = LED[:from], to_id = LED[:to])
      command_id = LED[:id]
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end

    STATE = {
      id:   0x2C,
      to:   :anzv,
      from: :tel
    }.freeze

    # STATE_DEFAULTS = {
    #
    # }

    # @param state: Number of CD loaded into changer
    def status(command_arguments, from_id = STATE[:from], to_id = STATE[:to])
      command_id = STATE[:id]
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end
  end
end
