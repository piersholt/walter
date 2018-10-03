require 'api/base_api'

module API
  module Media
    include BaseAPI

    COMMAND_ID = 0x23
    FROM_DEFAULT = Devices::RAD
    TO_DEFAULT = Devices::GLOH


    def media_display(command_arguments, from_id = FROM_DEFAULT, to_id = TO_DEFAULT)
      # LOGGER.warn('API') { "#media_display(from_id=#{from_id}, to_id=#{to_id})" }
      command_id = COMMAND_ID
      format_chars!(command_arguments)
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end

    HUD_TEXT = {
      id:   0x23,
      from: Devices::IKE,
      to:   Devices::GLOH
    }.freeze

    def obc(command_arguments, from_id = HUD_TEXT[:from], to_id = HUD_TEXT[:to])
      command_id = 0x23

      command_arguments[:gfx] = 0x06 unless command_arguments.key?(:gfx)
      command_arguments[:ike] = 0x00 unless command_arguments.key?(:ike)
      command_arguments[:chars] = "Range 123KM"  unless command_arguments.key?(:chars)

      format_chars!(command_arguments, false)
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end
  end
end
