# frozen_string_literal: false

module Wilhelm
  module Core
    module DataLink
      # Data logging
      module Capture
        MODE = 'a'
        TIME_STAMP = [:strftime, '%F']

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
