# frozen_string_literal: true

# require 'application/message'
# require 'maps/device_map'
# require 'maps/command_map'
# require 'maps/address_lookup_table'

require 'data_link/frame/indexed_arguments'

require 'data_link/frame/frame_builder'

# require 'application/commands/parameter/indexed_bit_array'
# # require 'application/commands/parameter/base_parameter'

# require 'application/commands/builder/base_command_builder'

require 'data_link/packet'

module DataLink
  module LogicalLinkLayer
    # Comment
    class Multiplexer
      include Event

      attr_reader :frame_output_buffer, :packet_output_buffer, :write_thread

      def initialize(frame_output_buffer)
        @frame_output_buffer = frame_output_buffer
        @packet_output_buffer = SizedQueue.new(32)
        @threads = ThreadGroup.new
      end

      def name
        'Multiplexer'
      end

      def off
        LogActually.datalink.debug(name) { "#{self.class}#off" }
        close_threads
      end

      def on
        LogActually.datalink.debug(name) { "#{self.class}#on" }
        @write_thread = thread_write_output_frame_buffer(@frame_output_buffer, @packet_output_buffer)
        @threads.add(@write_thread)
        true
      rescue StandardError => e
        LogActually.datalink.error(e)
        e.backtrace.each { |l| LogActually.datalink.error(l) }
        raise e
      end

      def thread_write_output_frame_buffer(frame_output_buffer)
        LogActually.datalink.debug(name) { 'New Thread: Frame Multiplexing' }
        Thread.new do
          Thread.current[:name] = name
          begin
            loop do
              message = packet_output_buffer.pop
              new_frame = multiplex(message)
              LogActually.datalink.unknown(PROG_NAME) { "frame_output_buffer.push(#{new_frame})" }
              frame_output_buffer.push(new_frame)
            end
          rescue StandardError => e
            LogActually.datalink.error(name) { e }
            e.backtrace.each { |l| LogActually.datalink.error(l) }
          end
          LogActually.datalink.warn(name) { "End Thread: Frame Multiplexing" }
        end
      end

      private

      # @return Frame
      def multiplex(message)
        frame_builder = FrameBuilder.new

        frame_builder.from = message.from.d
        frame_builder.to = message.to.d
        frame_builder.command = message.command

        frame = frame_builder.result
        LogActually.datalink.debug('MultiplexingHandler') { "Frame build: #{frame}" }
        frame
      end
    end
  end
end
