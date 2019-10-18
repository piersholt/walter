# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module GT
        class Augmented < Device::Augmented
          module State
            # GT::Augmented::State::Sent
            module Sent
              include Virtual::Constants::Events::Display
              include Virtual::Constants::Controls::BMBT
              include Constants

              # Command 0x01 PING
              def evaluate_ping(*)
                changed
                notify_observers(GT_PING, device: ident)
              end

              # Command 0x02 PONG
              def evaluate_pong(command)
                case command.status.value
                when 0x40
                  changed
                  notify_observers(GT_ANNOUNCE, device: ident)
                end
              end

              # Command 0x05 LCD_SET
              def evaluate_lcd_set(*)
                changed
                notify_observers(
                  GT_SET_BOOL,
                  device: ident,
                  menu: :on_board_computer
                )
              end

              # Command 0x31 INPUT
              def evaluate_input(command)
                case command.layout.value
                when RADIO_LAYOUTS
                  index = button_id(command.button)
                  state = button_state(command.button)
                  changed
                  notify_observers(GT_CONTROL, index: index, state: state)
                end
              end

              # Command 0x34 DSP-SET
              def evaluate_dsp_set(*)
                notify_observers(
                  GT_DSP,
                  device: ident,
                  menu: :dsp
                )
              end

              # Command 0x40 OBC-VAR
              def evaluate_obc_var(command)
                id = command.field.value
                # Notify when a parameter is requested for render.
                # Used to set API::Display state to Busy when
                # display is OBC, Settings, or Aux. Heat/Vent.
                return false unless VARIABLE_FIELDS.include?(id)
                changed
                event =
                  case id
                  when *FIELDS_VAR_SETTINGS
                    GT_SET_BOOL
                  when *FIELDS_VAR_OBC
                    GT_OBC_BOOL
                  when *FIELDS_VAR_CODE
                    GT_CODE_BOOL
                  when *FIELDS_VAR_AUX
                    GT_AUX_BOOL
                  end
                notify_observers(
                  event,
                  device: ident,
                  menu: :on_board_computer
                )
              end

              # Command 0x41 OBC_BOOL
              def evaluate_obc_bool(command)
                id = command.field.value
                # Notify when a parameter is requested for render.
                # Used to set API::Display state to Busy when
                # display is OBC, Settings, or Aux. Heat/Vent.
                return false unless REQUESTED_FIELDS.include?(id)
                changed
                event =
                  case id
                  when *FIELDS_BOOL_SETTINGS
                    GT_SET_BOOL
                  when *FIELDS_BOOL_OBC
                    GT_OBC_BOOL
                  when *FIELDS_BOOL_AUX
                    GT_AUX_BOOL
                  end
                notify_observers(
                  event,
                  device: ident,
                  menu: :on_board_computer
                )
              end

              # Command 0x45 MENU_GT
              def evaluate_menu_gt(command)
                case command.config.value
                when HIDE_RADIO
                  changed
                  notify_observers(BMBT_MENU, device: ident)
                end
              end

              # Command 0x4E SRC_SND
              def evaluate_src_snd(*); end

              # Command 0x4F SRC-GT
              def evaluate_src_gt(message)
                logger.debug(moi) { '#evaluate_src_gt' }
                return false if message.to?(:nav_jp)
                case message.command.a.parameters[:power].ugly
                when :powered
                  monitor_on
                when :unpowered
                  monitor_off
                end
              end

              private

              def button_id(button)
                button.parameters[:id].value
              end

              def button_state(button)
                button.parameters[:state].ugly
              end
            end
          end
        end
      end
    end
  end
end
