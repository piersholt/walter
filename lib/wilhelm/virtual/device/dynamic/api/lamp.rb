# require '/api/base_api'

# ignition
# speed

module Wilhelm
  module Virtual
    module API
      module Lamp
        include BaseAPI

        STATUS = {
          id:   0x5B,
          from: Devices::LCM,
          to:   Devices::GLOL
        }.freeze

        def lamp(command_arguments, from_id = STATUS[:from], to_id = STATUS[:to])
          command_id = STATUS[:id]
          give_it_a_go(from_id, to_id, command_id, command_arguments)
        end
      end
    end
  end
end
