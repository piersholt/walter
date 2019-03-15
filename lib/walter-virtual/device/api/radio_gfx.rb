# require '/api/base_api'

module API
  module RadioGFX
    include BaseAPI

    COMMAND_ID = 0x46
    TO_DEFAULT = Devices::RAD
    FROM_DEFAULT = Devices::GFX

    def gfx(command_arguments, from_id = FROM_DEFAULT, to_id = TO_DEFAULT)
      command_id = COMMAND_ID
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end
  end
end
