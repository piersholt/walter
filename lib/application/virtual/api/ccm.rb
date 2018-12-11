require 'application/virtual/api/base_api'
require 'helpers'

module API
  module CCM
    include BaseAPI
    include ClusterTools

    CCM_ALERT = {
      id:   0x1A,
      from: Devices::IKE,
      to:   Devices::GLOL
    }.freeze

    # @param Integer  mode
    # @param Integer  control
    # @param String   chars
    def alert(command_arguments, from_id = CCM_ALERT[:from], to_id = CCM_ALERT[:to])
      command_id = CCM_ALERT[:id]
      format_chars!(command_arguments)
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end
  end
end
