# frozen_string_literal: true

module Wilhelm
  class Virtual
    class AugmentedRadio < AugmentedDevice
      module State
        # Comment
        module Received
          include Constants

          def handle_menu_gfx(command)
            # logger.unknown(command.instance_variables)
            # logger.unknown(command.config.class)
            # logger.unknown(command.config.instance_variables)
            # logger.unknown(command.config.parameters)
            # command.config.parameters.each do |k,v|
            #   logger.unknown(v.instance_variables)
            #   v.instance_variables.each do |iv|
            #     logger.unknown(v.instance_variable_get(iv))
            #   end
            # end
            case command.config.value
            when 0b0000_0001
              background
              audio_obc_off
            when 0b0000_0010
              audio_obc_on
            when 0b0000_0011
              background
              audio_obc_on
            end
          end

          def handle_source_sound(command)
            case command.source.value
            when 0x00
              radio
            when 0x01
              background
              tv
            else
              logger.warn(self.class) { "Unknown SRC-SND value: #{command.source.value}" }
            end
          end

          # Handlers?
          def handle_bmbt_1_button(message)
            # LogActually.rad.debug('Radio') { "Handling: BMBT-1" }
            value = message.command.action.parameters[:totally_unique_variable_name].value

            case value
            when POWER_PRESS
              # LogActually.rad.debug('Radio') { "POWER_PRESS" }
              switch_power
            when MODE_PREV_PRESS
              # LogActually.rad.debug('Radio') { "MODE_PREV_PRESS" }
              previous_source
            when MODE_NEXT_PRESS
              # LogActually.rad.debug('Radio') { "MODE_NEXT_PRESS" }
              next_source
            when MENU_PRESS
            when OVERLAY_PRESS
            when AUX_HEAT_PRESS
            end
          end
        end
      end
    end
  end
end
