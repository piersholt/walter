# frozen_string_literal: false

module Wilhelm
  module SDK
    class UserInterface
      module View
        module Header
          # Comment
          class Status < DefaultHeader
            def initialize(status_model)
              LOGGER.unknown(moi) { "#initialize(#{status_model})" }
              super(
                ['A',
                  'B',
                  'C',
                  'D',
                  'E',
                  status_model.field(5),
                  status_model.field(6)],
                  'Wilhelm')
                rescue StandardError => e
                  LOGGER.error(self.class.name) { e }
                  e.backtrace.each { |line| LOGGER.error(self.class.name) { line } }
                  LOGGER.error(self.class.name) { 'binding.pry start' }
                  binding.pry
                  LOGGER.error(self.class.name) { 'binding.pry end' }
                end

                def moi
                  'Header Status'
                end
              end
            end
          end
        end
      end
end
