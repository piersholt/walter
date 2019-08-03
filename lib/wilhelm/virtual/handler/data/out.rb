# frozen_string_literal: true

module Wilhelm
  module Virtual
    module Handler
      class DataHandler < Core::BaseHandler
        # Virtual::Handler::DataHandler
        module Out
          include LogActually::ErrorOutput
          include Core::Constants::Events

          PROG = 'Handler::Data::Out'

          def data_sent(properties)
            message = data?(properties)
            data = generate_data(message)
            add_to_output_buffer(data)
          end

          private

          # SEND: GENERATE (Command -> Data)

          # @note Command::Generate
          def generate_data(message)
            from    = message.from
            to      = message.to
            payload = message_data(message)

            Core::Data.new(from, to, payload)
          end

          # HACK: BaseCommand::Raw has no sender/receiver in scope!
          def message_data(message)
            message.command.load_command_config(message.from, message.to)
            message.command.generate
          end

          def add_to_output_buffer(data)
            result = @data_output_buffer.push(data)
            LOGGER.debug(PROG) { "#add_to_output_buffer(#{data}) => #{result}" }
            result
          end
        end
      end
    end
  end
end
