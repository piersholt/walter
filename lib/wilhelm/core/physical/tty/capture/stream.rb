# frozen_string_literal: false

module Wilhelm
  module Core
    class Interface
      module TTY
        # Data logging
        module Capture
          MODE = 'a'
          TIME_STAMP = [:strftime, '%F']

          class ByteStream < ::File
            PATH = LOG_BIN_PATH
            EXTENTION = '.bin'

            def initialize
              super("#{PATH}/#{Time.now.public_send(*TIME_STAMP)}#{EXTENTION}", MODE)
            end
          end

          class FrameStream < ::File
            PATH = LOG_FRAME_PATH
            EXTENTION = '.log'

            def initialize
              super("#{PATH}/#{Time.now.public_send(*TIME_STAMP)}#{EXTENTION}", MODE)
            end
          end
        end
      end
    end
  end
end
