require 'api/base_api'
require 'helpers'

module API
  module CCM
    include BaseAPI
    include ClusterTools

    COMMAND_ID = 0x1A
    TO_DEFAULT = Devices::IKE
    FROM_DEFAULT = Devices::CCM

    # @param Integer  mode
    # @param Integer  control
    # @param String   chars
    def alert(command_arguments, from_id = FROM_DEFAULT, to_id = TO_DEFAULT)
      command_id = COMMAND_ID
      format_chars!(command_arguments)
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end
  end
end
