# frozen_string_literal: true

# Comment
class Virtual
  class AugmentedRAD < AugmentedDevice
    include API::Media
    PROC = 'AugmentedRAD'.freeze

    def handle_message(message)
      LOGGER.warn(PROC) { 'i am a trying to handle this hokay!' }
      command_id = message.command.d
      LOGGER.warn(PROC) { 'hooookay!' + "#{command_id}" }
      case command_id
      when MFL_FUNC
        LOGGER.warn(PROC) { 'i got the MFL funk baby!' }
        handle_button_press(message)
      when MFL_VOL
        # changed(true)
        # notify_observers(SEEK)
        true
      end
    end

    # ----------------------- TO HANDLER MODULE --------------------- #

    def handle_button_press(message)
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

    # ----------------------- AUGMENTED HANDLING --------------------- #
    def track_change(track)
      return false if @thread
      @thread = Thread.new(track) do |t|
        begin
          LOGGER.fatal(self.class) { t }
          title = t['Title']
          artist = t['Artist']
          scroll = "#{title} / #{artist}"

          displays( { chars: '', gfx: 0xC4, ike: 0x20,}, my_address, address(:ike) )

          i = 0
          last = scroll.length

          while i <= last do
            scroll = scroll.bytes.rotate(i).map { |i| i.chr }.join
            displays( { chars: scroll, gfx: 0xC4, ike: 0x30,}, my_address, address(:ike) )
            sleep(2)
            i += 1
          end
        rescue StandardError => e
          LOGGER.error(self.class) { e }
        end
      end
      @thread = nil
      true
    end
  end
end
