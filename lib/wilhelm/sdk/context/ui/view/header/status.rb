# frozen_string_literal: false

module Wilhelm
  module SDK
    class Context
      class UserInterface
        module View
          module Header
            # Context::UserInterface::View::Header::Status
            class Status < UIKit::View::BaseHeader
              PROC = 'View::Header::Status'.freeze

              def initialize(status_model)
                LOGGER.unknown(PROC) { "#initialize(#{status_model})" }
                super(
                  [status_model.field(0), 'B', 'C', 'D', 'E', status_model.field(5), status_model.field(6)],
                  'Wilhelm'
                )
              rescue StandardError => e
                LOGGER.error(PROC) { e }
                e.backtrace.each { |line| LOGGER.error(PROC) { line } }
                LOGGER.error(PROC) { 'binding.pry start' }
                binding.pry
                LOGGER.error(PROC) { 'binding.pry end' }
              end
            end
          end
        end
      end
    end
  end
end
