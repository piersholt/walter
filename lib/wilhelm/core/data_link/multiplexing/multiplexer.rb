# frozen_string_literal: true

module Wilhelm
  module Core
    module DataLink
      # Comment
      class Multiplexer
        include ManageableThreads
        include Constants::Events

        attr_reader :frame_output_buffer, :packet_output_buffer, :write_thread

        def initialize(frame_output_buffer)
          @frame_output_buffer = frame_output_buffer
          @packet_output_buffer = SizedQueue.new(32)
          @threads = ThreadGroup.new
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

        def off
          LOGGER.debug(name) { "#{self.class}#off" }
          close_threads
        end

        private

        def name
          'Multiplexer'
        end

        alias proc_name name

        def thread_write_output_frame_buffer(frame_output_buffer, packet_output_buffer)
          LOGGER.debug(name) { 'New Thread: Frame Multiplexing' }
          Thread.new do
            Thread.current[:name] = name
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
            LOGGER.warn(name) { "End Thread: Frame Multiplexing" }
          end
        end

        # @return Frame
        def multiplex(message)
          LOGGER.debug(name) { "#multiplex(#{message})" }
          frame_builder = Frame::Builder.new
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
