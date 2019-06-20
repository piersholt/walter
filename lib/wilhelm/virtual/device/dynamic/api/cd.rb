# frozen_string_literal: true

module Wilhelm
  module Virtual
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
        def cdc_status_reply(command_arguments, from_id = STATUS[:from], to_id = STATUS[:to])
          # LOGGER.warn(PROC) { (command_arguments) }
          command_id = STATUS[:id]
          give_it_a_go(from_id, to_id, command_id, command_arguments)
        end
      end
    end
  end
end
