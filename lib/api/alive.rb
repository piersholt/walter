# frozen_string_literal: true

require 'api/base_api'

module API
  # API for command related to keys
  module Alive
    include BaseAPI

    PING = {
      id:   0x01,
      to:   :ike,
      from: :glo_l
    }.freeze

    PONG = {
      id:   0x02,
      to:   :glo_l,
      from: :ike
    }.freeze

    # @param Status: Pong Type
    def pong(command_arguments, from_id = PONG[:from], to_id = PONG[:to])
      command_id = PONG[:id]
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end
  end
end
