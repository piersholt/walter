# frozen_string_literal: false

module Wilhelm::SDK
  class UserInterface
    module View
      module Header
        # Comment
        class Status < DefaultHeader
          def initialize(status_model)
            LogActually.ui.unknown(moi) { "#initialize(#{status_model})" }
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
             LogActually.ui.error(self.class.name) { e }
             e.backtrace.each { |line| LogActually.ui.error(self.class.name) { line } }
             LogActually.ui.error(self.class.name) { 'binding.pry start' }
             binding.pry
             LogActually.ui.error(self.class.name) { 'binding.pry end' }
          end

          def moi
            'Header Status'
          end
        end
      end
    end
  end
end
