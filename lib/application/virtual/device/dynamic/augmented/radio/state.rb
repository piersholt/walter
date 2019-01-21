# frozen_string_literal: true

class Virtual
  class AugmentedRadio < AugmentedDevice
    module State
      include Constants
      include Model
      include Chainable

      def evaluate_menu_rad(command)
        case command.state.value
        when 0b0000_0001
          background
        when (0b0000_0010..0b0000_1111)
          body_hide
        end
      end

      def evaluate_display_layout(command)
        case command.gfx.value
        when (0x40..0x5F)
          radio
          radio_layout
        when (0x60..0x7F)
          external
        when (0x80..0x9F)
          tape
          tape_layout
        when (0xc0..0xcF)
          cdc
          cdc_layout
        end
      end

      def evaluate_radio_led(command)
        case command.led.value
        when 0x00
          off
        when 0x90
          off
        when 0xFF
          on
        when 0x48
          radio
          on
        when (0x41..0x45)
          tape
          on
        when (0x5a..0x5f)
          tape
          on
        else
          logger.warn(self.class) { "Unknown RAD-LED value: #{command.led.value}" }
        end
      end

      def evaluate_radio_alt(command)
        case command.mode.value
        when (0x40..0x70)
          body_select
        when (0x80..0xff)
          body_eq
        else
          logger.warn(self.class) { "Unknown RAD-ALT value: #{command.mode.value}" }
        end
      end

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
        value = message.command.totally_unique_variable_name

        case value
        when POWER_PRESS
          LogActually.rad.debug('Radio') { "POWER_PRESS" }
          switch_power
        when MODE_PREV_PRESS
          LogActually.rad.debug('Radio') { "MODE_PREV_PRESS" }
          previous_source
        when MODE_NEXT_PRESS
          LogActually.rad.debug('Radio') { "MODE_NEXT_PRESS" }
          next_source
        when MENU_PRESS
        when OVERLAY_PRESS
        when AUX_HEAT_PRESS
        end
      end
    end
  end
end
