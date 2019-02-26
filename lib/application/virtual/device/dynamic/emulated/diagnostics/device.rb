# frozen_string_literal: true

# Comment
class Virtual
  # Comment
  class ManualDiagnostics < EmulatedDevice
    # include API::Diagnostics
    include Capabilities::Diagnostics

    PROC = 'ManualDiagnostics'

    def type
      :augmented
    end

    # @override Object#inspect
    def inspect
      "#<AugmentedDevice :#{@ident}>"
    end

    # @override Object#to_s
    def to_s
      "<:#{@ident}>"
    end

    def handle_virtual_receive(message)
      command_id = message.command.d
      # return super if command_id == PING
      LOGGER.unknown(PROC) { "Handle? #{message.from} -> #{message.command.h}" }

      if CommandGroups::DIAGNOSTICS.include?(command_id)
        LOGGER.unknown(PROC) { "Diagnostic reply! #{message.command.h}" }
      end

    rescue StandardError => e
      LOGGER.error(self.class) { e }
      e.backtrace.each { |line| LOGGER.error(self.class) { line } }
    end
  end
end
