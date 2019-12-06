# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        class Augmented < Device::Augmented
          module State
            # Device::Radio::Augmented
            module Received
              include Constants

              def handle_menu_gt(command)
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
                when HIDE_RADIO
                  background
                  audio_obc_off
                when HEADER_ONLY
                  audio_obc_on
                when HIDE_RADIO | HEADER_ONLY
                  background
                  audio_obc_on
                end
              end

              def handle_source_sound(command)
                case command.source.value
                when SOURCE_RADIO
                  radio
                when SOURCE_TV
                  background
                  tv
                else
                  logger.warn(self.class) { "Unknown SRC-SND value: #{command.source.value}" }
                end
              end

              # 0x48 BMBT-BTN
              def handle_bmbt_1_button(message)
                # LOGGER.debug('Radio') { "Handling: BMBT-1" }
                value = message.command.action.parameters[:totally_unique_variable_name].value

                case value
                when POWER_PRESS
                  # LOGGER.debug('Radio') { "POWER_PRESS" }
                  switch_power
                when MODE_PREV_PRESS
                  # LOGGER.debug('Radio') { "MODE_PREV_PRESS" }
                  previous_source
                when MODE_NEXT_PRESS
                  # LOGGER.debug('Radio') { "MODE_NEXT_PRESS" }
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
  end
end
