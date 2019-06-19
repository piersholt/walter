# frozen_string_literal: true

# require '/api/base_api'

module Wilhelm
  class Virtual
    module API
      # API for command related to keys
      module Key
        include BaseAPI

        REQUEST = {
          id:   0x73,
          to:   Devices::IKE,
          from: Devices::GLOL
        }.freeze

        STATUS = {
          id:   0x74,
          to:   Devices::GLOL,
          from: Devices::IKE
        }.freeze

        # @param Key: ID of key
        # @param Status: status of key
        def state(command_arguments, from_id = STATUS[:from], to_id = STATUS[:to])
          command_id = STATUS[:id]
          give_it_a_go(from_id, to_id, command_id, command_arguments)
        end
      end
    end
  end
end
