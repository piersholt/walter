require 'api/base_api'

module API
  module Media
    include BaseAPI

    COMMAND_ID = 0x23
    TO_DEFAULT = Devices::GLOH
    FROM_DEFAULT = Devices::RAD

    def update(command_arguments, from_id = FROM_DEFAULT, to_id = TO_DEFAULT)
      command_id = COMMAND_ID
      format_chars(command_arguments)
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end
  end
end
