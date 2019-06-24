# frozen_string_literal: true

module Wilhelm
  module Core
    module DataLink
      # Comment
      class Demultiplexer
        include Observable
        include ManageableThreads
        include Constants::Events

        attr_reader :input_buffer, :output_buffer, :read_thread

        def initialize(input_buffer)
          @input_buffer = input_buffer
          @output_buffer = SizedQueue.new(32)
        end

        def on
          LOGGER.debug(name) { '#on' }
          @read_thread = thread_read_input_frame_buffer(@input_buffer, @output_buffer)
          add_thread(@read_thread)
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
          'Demultiplexer'
        end

        alias proc_name name

        def thread_read_input_frame_buffer(input_buffer, output_buffer)
          LOGGER.debug(name) { 'New Thread: Frame Demultiplexing' }
          Thread.new do
            Thread.current[:name] = name
            begin
              loop do
                new_frame = input_buffer.pop
                new_packet = demultiplex(new_frame)

                changed
                notify_observers(PACKET_RECEIVED, packet: new_packet)

                # LOGGER.unknown(PROG_NAME) { "output_buffer.push(#{new_packet})" }
                # output_buffer.push(new_packet)
              end
            rescue StandardError => e
              LOGGER.error(name) { e }
              e.backtrace.each { |l| LOGGER.error(l) }
            end
            LOGGER.warn(name) { "End Thread: Frame Demultiplexing" }
          end
        end

        def demultiplex(frame)
          LOGGER.debug(name) { "#demultiplex(#{frame})" }
          from_device = frame.from.to_i
          to_device   = frame.to.to_i
          payload   = frame.payload

          packet = Packet.new(from_device, to_device, payload)
          LOGGER.debug(name) { "Packet build: #{packet}" }
          packet
        rescue TypeError => e
          LOGGER.error(name) { e }
          LOGGER.error(name) { e.cause }
          e.backtrace.each { |l| LOGGER.error(l) }
        rescue StandardError => e
          LOGGER.error(name) { e }
          e.backtrace.each { |l| LOGGER.error(l) }
        end
      end
    end
  end
end
