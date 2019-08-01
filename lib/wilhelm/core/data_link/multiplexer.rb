# frozen_string_literal: true

module Wilhelm
  module Core
    module DataLink
      # Core::DataLink::Multiplexer
      class Multiplexer
        include ManageableThreads
        include Constants::Events

        NAME = 'Multiplexer'
        THREAD_NAME = 'wilhelm-core/data_link Multiplexer (Output Buffer)'

        attr_reader :frame_output_buffer, :packet_output_buffer, :write_thread

        def initialize(frame_output_buffer)
          @frame_output_buffer = frame_output_buffer
          @packet_output_buffer = SizedQueue.new(32)
          @threads = ThreadGroup.new
        end

        def on
          LOGGER.debug(name) { '#on' }
          @write_thread = thread_write_output_frame_buffer(@frame_output_buffer, @packet_output_buffer)
          add_thread(@write_thread)
          true
        rescue StandardError => e
          LOGGER.error(e)
          e.backtrace.each { |l| LOGGER.error(l) }
          raise e
        end

        def off
          LOGGER.debug(name) { '#off' }
          close_threads
        end

        private

        def name
          NAME
        end

        # @override: ManageableThreads#proc_name
        alias proc_name name

        LOG_WRITE_THREAD_START = 'New Thread: Frame Multiplexing'
        LOG_WRITE_THREAD_END = 'End Thread: Frame Multiplexing'

        def thread_write_output_frame_buffer(frame_output_buffer, packet_output_buffer)
          LOGGER.debug(name) { LOG_WRITE_THREAD_START }
          Thread.new do
            Thread.current[:name] = THREAD_NAME
            begin
              loop do
                message = packet_output_buffer.pop
                new_frame = multiplex(message)
                LOGGER.debug(name) { "frame_output_buffer.push(#{new_frame}) (#{Thread.current})" }
                frame_output_buffer.push(new_frame)
              end
            rescue StandardError => e
              LOGGER.error(name) { e }
              e.backtrace.each { |l| LOGGER.error(l) }
            end
            LOGGER.warn(name) { LOG_WRITE_THREAD_END }
          end
        end

        def multiplex(message)
          LOGGER.debug(name) { "#multiplex(#{message})" }
          frame_builder = Frame::Builder.new
          frame_builder.from = message.from
          frame_builder.to = message.to
          # HACK BaseCommand::Raw has no sender/receiver in scope!
          message.command.load_command_config(message.from, message.to)
          frame_builder.payload = message.command.generate

          frame = frame_builder.result
          LOGGER.debug(name) { "Frame build: [#{frame.h.join(' ')}]" }
          frame
        end
      end
    end
  end
end
