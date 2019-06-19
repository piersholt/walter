# frozen_string_literal: true

module Wilhelm
  module Core
    module DataLink
      module LogicalLinkLayer
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
            LogActually.multiplexer.debug(name) { "#{self.class}#off" }
            close_threads
          end

          def on
            LogActually.multiplexer.debug(name) { "#{self.class}#on" }
            @write_thread = thread_write_output_frame_buffer(@frame_output_buffer, @packet_output_buffer)
            @threads.add(@write_thread)
            true
          rescue StandardError => e
            LogActually.multiplexer.error(e)
            e.backtrace.each { |l| LogActually.multiplexer.error(l) }
            raise e
          end

          def thread_write_output_frame_buffer(frame_output_buffer, packet_output_buffer)
            LogActually.multiplexer.debug(name) { 'New Thread: Frame Multiplexing' }
            Thread.new do
              Thread.current[:name] = name
              begin
                loop do
                  message = packet_output_buffer.pop
                  message = resolve_addresses(message)
                  new_frame = multiplex(message)
                  LogActually.multiplexer.debug(name) { "frame_output_buffer.push(#{new_frame}) (#{Thread.current})" }
                  frame_output_buffer.push(new_frame)
                end
              rescue StandardError => e
                LogActually.multiplexer.error(name) { e }
                e.backtrace.each { |l| LogActually.multiplexer.error(l) }
              end
              LogActually.multiplexer.warn(name) { "End Thread: Frame Multiplexing" }
            end
          end

          private

          def resolve_addresses(message)
            LogActually.multiplexer.debug(name) { "#resolve_addresses(#{message})" }

            from = address_lookup_table.resolve_ident(message.from)
            message.sender = from
            LogActually.demultiplexer.debug(name) { "from_device: #{message.sender}" }

            to = address_lookup_table.resolve_ident(message.to)
            message.receiver = to
            LogActually.demultiplexer.debug(name) { "to_device: #{message.receiver}" }

            message
          end

          # @return Frame
          def multiplex(message)
            LogActually.multiplexer.debug(name) { "#multiplex(#{message})" }
            frame_builder = FrameBuilder.new
            frame_builder.from = message.from
            frame_builder.to = message.to
            frame_builder.command = message.command

            frame = frame_builder.result
            LogActually.multiplexer.debug(name) { "Frame build: [#{frame.h.join(' ')}]" }
            frame
          end
        end
      end
    end
  end
end
