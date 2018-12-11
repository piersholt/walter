# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class AugmentedRAD
    # User Input to be published
    class Actions
      include API::Media
      
      def handle_message(message)
        LOGGER.debug(PROC) { "#handle_message(#{message})" }
        command_id = message.command.d
        LOGGER.debug(PROC) { "Command ID: #{command_id}" }

        case command_id
        when MFL_FUNC
          LOGGER.debug(PROC) { "#{command_id} => #{MFL_VOL}" }
          mfl_func(message)
        when MFL_VOL
          LOGGER.debug(PROC) { "#{command_id} => #{MFL_VOL}" }
        when BMBT_A
          LOGGER.debug(PROC) { "#{command_id} => #{BMBT_A}" }
        when BMBT_B
          LOGGER.debug(PROC) { "#{command_id} => #{BMBT_B}" }
        when Command::Aliases::BUTTONS
          LOGGER.warn(PROC) { "#{command_id} should be handled!" }
        end
      end

      private

      def mfl_func(message)
        seek = [0x01, 0x11, 0x21, 0x08, 0x18, 0x28]

        seek_next = [0x01, 0x11, 0x21]
        seek_previous = [0x08, 0x18, 0x28]

        button_press = [0x01, 0x08]
        button_hold = [0x11, 0x18]
        button_release = [0x21, 0x28]

        value = message.command.totally_unique_variable_name

        if seek.any? { |x| x == value }
          if seek_next.any? { |x| x == value }
            variant = NEXT
          elsif seek_previous.any? { |x| x == value }
            variant = PREVIOUS
          end

          if button_press.any? { |x| x == value }
            state = PRESS
          elsif button_hold.any? { |x| x == value }
            state = HOLD
          elsif button_release.any? { |x| x == value }
            state = RELEASE
          end

          changed(true)
          notify_observers(SEEK, variant: variant, control: BUTTON, state: state)
        end
      end
    end
  end
end
