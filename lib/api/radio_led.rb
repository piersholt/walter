require 'api/base_api'

module API
  module RadioLED
    include BaseAPI

    COMMAND_ID = 0x4A
    TO_DEFAULT = Devices::BMBT
    FROM_DEFAULT = Devices::RAD

    def switch(command_arguments, from_id = FROM_DEFAULT, to_id = TO_DEFAULT)
      command_id = COMMAND_ID
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end
  end
end
