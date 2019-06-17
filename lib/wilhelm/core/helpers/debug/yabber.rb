# frozen_string_literal: false

module Wilhelm
  module Core
    # DebugTools
    # Helpers for common tasks on CLI
    module Debug
      module Yabber
        LOG_LEVEL_MAP = {
          d: :debug,
          i: :info,
          w: :warn,
          e: :error
        }.freeze

        YABBER_LOGS = %i[messaging client publisher server subscriber].freeze

        def yap(level = :w)
          return false unless LOG_LEVEL_MAP.key?(level)
          YABBER_LOGS.each do |log|
            LOGGER.info('Debug') { "#{log} to #{LOG_LEVEL_MAP[level].upcase}" }
            LogActually.public_send(log)&.public_send(level)
          end
          true
        end
      end
    end
  end
end
