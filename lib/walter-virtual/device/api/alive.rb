# frozen_string_literal: true

# require 'application/virtual/api/base_api'

module API
  # API for command related to keys
  module Alive
    include BaseAPI

    PING_FUCK_OFF = {
      id:   0x01,
      to:   :ike,
      from: :glo_l
    }.freeze

    PONG_FUCK_OFF = {
      id:   0x02,
      to:   :glo_l,
      from: :ike
    }.freeze

    # @param Status: Pong Type
    def pong(command_arguments, from_id = PONG_FUCK_OFF[:from], to_id = PONG_FUCK_OFF[:to])
      LOGGER.warn(self.class) { 'Deprecated!' }
      # LOGGER.warn('API::Alive') { 'trying to pong?' }
      command_id = PONG_FUCK_OFF[:id]
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end
  end
end
