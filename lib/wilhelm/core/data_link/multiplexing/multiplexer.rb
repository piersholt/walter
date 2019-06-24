# frozen_string_literal: true

module Wilhelm
  module Core
    module DataLink
      # Comment
      class Multiplexer
        include Constants::Events
        include ManageableThreads

        attr_reader :frame_output_buffer, :packet_output_buffer, :write_thread, :address_lookup_table

        def initialize(frame_output_buffer, address_lookup_table = AddressLookupTable.instance)
          @frame_output_buffer = frame_output_buffer
          @packet_output_buffer = SizedQueue.new(32)
          @threads = ThreadGroup.new
          @address_lookup_table = address_lookup_table
        end

        def name
          'Multiplexer'
        end

        alias proc_name name

        def off
          LOGGER.debug(name) { "#{self.class}#off" }
          close_threads
        end

        def on
          LOGGER.debug(name) { "#{self.class}#on" }
          @write_thread = thread_write_output_frame_buffer(@frame_output_buffer, @packet_output_buffer)
          @threads.add(@write_thread)
          true
        rescue StandardError => e
          LOGGER.error(e)
          e.backtrace.each { |l| LOGGER.error(l) }
          raise e
        end

        def thread_write_output_frame_buffer(frame_output_buffer, packet_output_buffer)
          LOGGER.debug(name) { 'New Thread: Frame Multiplexing' }
          Thread.new do
            Thread.current[:name] = name
            begin
              loop do
                message = packet_output_buffer.pop
                message = resolve_addresses(message)
                new_frame = multiplex(message)
                LOGGER.debug(name) { "frame_output_buffer.push(#{new_frame}) (#{Thread.current})" }
                frame_output_buffer.push(new_frame)
              end
            rescue StandardError => e
              LOGGER.error(name) { e }
              e.backtrace.each { |l| LOGGER.error(l) }
            end
            LOGGER.warn(name) { "End Thread: Frame Multiplexing" }
          end
        end

        private

        def resolve_addresses(message)
          LOGGER.debug(name) { "#resolve_addresses(#{message})" }

          from = address_lookup_table.resolve_ident(message.from)
          message.sender = from
          LOGGER.debug(name) { "from_device: #{message.sender}" }

          to = address_lookup_table.resolve_ident(message.to)
          message.receiver = to
          LOGGER.debug(name) { "to_device: #{message.receiver}" }

          message
        end

        # @return Frame
        def multiplex(message)
          LOGGER.debug(name) { "#multiplex(#{message})" }
          frame_builder = FrameBuilder.new
          frame_builder.from = message.from
          frame_builder.to = message.to
          frame_builder.payload = message.command.raw

          frame = frame_builder.result
          LOGGER.debug(name) { "Frame build: [#{frame.h.join(' ')}]" }
          frame
        end
      end
    end
  end
end
