# frozen_string_literal: true

module Wilhelm
  module Core
    module DataLink
      # Comment
      class Demultiplexer
        include Observable
        include ManageableThreads
        include Constants::Events

        attr_reader :frame_input_buffer, :packet_input_buffer, :read_thread

        def initialize(frame_input_buffer, address_lookup_table = AddressLookupTable.instance)
          @frame_input_buffer = frame_input_buffer
          @packet_input_buffer = SizedQueue.new(32)
          @address_lookup_table = address_lookup_table
        end

        def on
          LogActually.demultiplexer.debug(name) { '#on' }
          @read_thread = thread_read_input_frame_buffer(@frame_input_buffer, @packet_input_buffer)
          add_thread(@read_thread)
          true
        rescue StandardError => e
          LogActually.demultiplexer.error(e)
          e.backtrace.each { |l| LogActually.demultiplexer.error(l) }
          raise e
        end

        def off
          LogActually.demultiplexer.debug(name) { '#off' }
          close_threads
        end

        private

        def name
          'Demultiplexer'
        end

        alias proc_name name

        def thread_read_input_frame_buffer(frame_input_buffer, packet_input_buffer)
          LogActually.demultiplexer.debug(name) { 'New Thread: Frame Demultiplexing' }
          Thread.new do
            Thread.current[:name] = name
            begin
              loop do
                new_frame = frame_input_buffer.pop
                new_packet = demultiplex(new_frame)

                changed
                notify_observers(PACKET_RECEIVED, packet: new_packet)

                # LogActually.demultiplexer.unknown(PROG_NAME) { "packet_input_buffer.push(#{new_packet})" }
                # packet_input_buffer.push(new_packet)
              end
            rescue StandardError => e
              LogActually.demultiplexer.error(name) { e }
              e.backtrace.each { |l| LogActually.demultiplexer.error(l) }
            end
            LogActually.demultiplexer.warn(name) { "End Thread: Frame Demultiplexing" }
          end
        end

        def demultiplex(frame)
          from      = frame.from
          from_id   = from.to_i
          from_device = @address_lookup_table.find(from_id)
          LogActually.demultiplexer.debug(name) { "from_device: #{from_device}" }

          to        = frame.to
          to_id     = to.to_i
          to_device   = @address_lookup_table.find(to_id)
          LogActually.demultiplexer.debug(name) { "to_device: #{to_device}" }

          payload   = frame.payload
          LogActually.demultiplexer.debug(name) { "payload: #{payload}" }

          packet = Packet.new(from_device, to_device, payload)
          LogActually.demultiplexer.debug(name) { "Packet build: #{packet}" }
          packet
        rescue TypeError => e
          LogActually.demultiplexer.error(name) { e }
          LogActually.demultiplexer.error(name) { e.cause }
          e.backtrace.each { |l| LogActually.demultiplexer.error(l) }
        rescue StandardError => e
          LogActually.demultiplexer.error(name) { e }
          e.backtrace.each { |l| LogActually.demultiplexer.error(l) }
        end
      end
    end
  end
end
