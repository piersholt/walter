# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Device
      module API
        # API::BaseAPI
        module BaseAPI
          include Wilhelm::Core::Constants::Events
          include Observable
          include Helpers::Cluster
          include LogActually::ErrorOutput

          NAME = 'BaseAPI'.freeze

          def resolve_ident(ident)
            AddressLookupTable.instance.resolve_ident(ident)
          end

          def name
            NAME
          end

          def try(from, to, command_id, command_arguments = {})
            from = resolve_ident(from)
            to = resolve_ident(to)
            command_object = to_command(command_id: command_id,
              command_arguments: command_arguments,
              schema_from: from,
              schema_to: to)

              send_it!(from, to, command_object)
            rescue StandardError => e
              LOGGER.error("#{self.class} StandardError: #{e}")
              e.backtrace.each { |l| LOGGER.error(l) }
              binding.pry
            end

            def send_it!(from, to, command)
              LOGGER.debug(name) { "#send_it!(#{from}, #{to}, #{command.inspect})" }
              message = Message.new(from, to, command)
              changed
              notify_observers(MESSAGE_SENT, message: message)
              true
            rescue StandardError => e
              LOGGER.error("#{self.class} StandardError: #{e}")
              e.backtrace.each { |l| LOGGER.error(l) }
              binding.pry
            end

            alias give_it_a_go try

            private

            def to_command(command_id:, command_arguments:, schema_from:, schema_to:)
              command_config = CommandMap.instance.config(command_id, from: schema_from, to: schema_to)
              command_builder = command_config.builder
              command_builder = command_builder.new(command_config)
              command_builder.add_parameters(command_arguments)
              command_builder.result
            rescue StandardError => e
              with_backtrace(LOGGER, e)
            end
          end
        end
    end
  end
end
