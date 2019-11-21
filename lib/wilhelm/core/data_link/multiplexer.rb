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
        LOG_WRITE_THREAD_START = 'New Thread: Frame Multiplexing'
        LOG_WRITE_THREAD_END = 'End Thread: Frame Multiplexing'

        attr_reader :frame_output_buffer, :packet_output_buffer, :write_thread

        def initialize(frame_output_buffer)
          @frame_output_buffer = frame_output_buffer
          @packet_output_buffer = SizedQueue.new(32)
        end

        def on
          LOGGER.debug(name) { '#on' }
          @write_thread = thread_write_output_frame_buffer(@frame_output_buffer, @packet_output_buffer)
          add_thread(@write_thread)
          true
        rescue StandardError => e
          LOGGER.error(name) { e }
          e.backtrace.each { |line| LOGGER.error(name) { line } }
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

        TRUE = true

        def thread_write_output_frame_buffer(frame_output_buffer, packet_output_buffer)
          LOGGER.debug(name) { LOG_WRITE_THREAD_START }
          Thread.new do
            Thread.current[:name] = THREAD_NAME
            while TRUE
              new_data = packet_output_buffer.pop
              new_frame = multiplex(new_data)
              distribute(frame_output_buffer, new_frame)
            end
            LOGGER.warn(name) { LOG_WRITE_THREAD_END }
          end
        end

        def multiplex(data)
          LOGGER.debug(name) { "#multiplex(#{data})" }
          frame_builder = Frame::Builder.new

          frame_builder.from = data.from
          frame_builder.to = data.to
          frame_builder.payload = data.payload

          frame = frame_builder.result
          LOGGER.debug(name) { "Frame build: [#{frame.h.join(' ')}]" }
          frame
        rescue StandardError => e
          LOGGER.error(name) { e }
          e.backtrace.each { |line| LOGGER.error(name) { line } }
        end

        def distribute(frame_output_buffer, new_frame)
          LOGGER.debug(name) { "frame_output_buffer.push(#{new_frame}) (#{Thread.current})" }
          frame_output_buffer.push(new_frame)
        end
      end
    end
  end
end
