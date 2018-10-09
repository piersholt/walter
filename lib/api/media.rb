require 'api/base_api'

module API
  module Media
    include BaseAPI

    DISPLAYS = {
      id:   0x23,
      from: Devices::RAD,
      to:   Devices::GLOH
    }.freeze

    def displays(command_arguments,
                 from_id = DISPLAYS[:from],
                 to_id = DISPLAYS[:to])
      command_id = DISPLAYS[:id]
      format_chars!(command_arguments, align: false)
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end

    HUD_TEXT = {
      id:   0x24,
      from: Devices::IKE,
      to:   Devices::GLOH
    }.freeze

    def hud(command_arguments, from_id = HUD_TEXT[:from], to_id = HUD_TEXT[:to])
      command_id = HUD_TEXT[:id]
      format_chars!(command_arguments, align: false)
      give_it_a_go(from_id, to_id, command_id, command_arguments)
    end
  end
end
