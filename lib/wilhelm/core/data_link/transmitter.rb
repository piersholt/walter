# frozen_string_literal: true

module Wilhelm
  module Core
    module DataLink
      # Comment
      class Transmitter
        include Observable
        include ManageableThreads

        NAME = 'Transmitter'
        THREAD_NAME = 'wilhelm-core/data_link Transmitter (Output Buffer)'
        MAX_RETRY = 3

        attr_reader :write_queue

        alias frame_output_buffer write_queue

        def initialize(output_buffer, write_queue = Queue.new)
          @output_buffer = output_buffer
          @write_queue = write_queue
        end

        def name
          NAME
        end

        # @override: ManageableThreads#proc_name
        alias proc_name name

        def off
          LOGGER.debug(name) { "#{self.class}#off" }
          close_threads
        end

        alias disable off

        def on
          LOGGER.debug(name) { "#{self.class}#on" }
          begin
            @write_thread = thread_write_buffer(@write_queue, @output_buffer)
            add_thread(@write_thread)
            true
          rescue StandardError => e
            LOGGER.error(e)
            e.backtrace.each { |l| LOGGER.error(l) }
            raise e
          end
          true
        end

        private

        # ------------------------------ THREADS ------------------------------ #

        def thread_write_buffer(write_queue, output_buffer)
          LOGGER.debug(name) { 'New Thread: Frame Write.' }
          Thread.new do
            Thread.current[:name] = THREAD_NAME
            transmission(write_queue, output_buffer)
            LOGGER.warn(name) { "#{self.class} thread is finished..!" }
          end
        end

        def transmission(write_queue, output_buffer)
          loop do
            more_transmission(write_queue, output_buffer)
          end
        rescue StandardError => e
          LOGGER.error(name) { "#{tn}: Exception: #{e}" }
          e.backtrace.each { |l| LOGGER.error(l) }
          binding.pry
        end

        def more_transmission(write_queue, output_buffer)
          LOGGER.debug(THREAD_NAME) { "Transmit queue length: #{write_queue.size}" }
          LOGGER.debug(THREAD_NAME) { "Get next frame in queue... (blocking)" }
          frame_to_write = write_queue.deq
          transmit(output_buffer, frame_to_write)
        rescue TransmissionError => e
          LOGGER.error(THREAD_NAME) { e }
          e.backtrace.each { |l| LOGGER.error(l) }
        rescue StandardError => e
          LOGGER.error(THREAD_NAME) { e }
          e.backtrace.each { |l| LOGGER.error(l) }
        end

        def transmit(output_buffer, frame_to_write)
          LOGGER.debug(THREAD_NAME) { "#transmit(#{output_buffer}, #{frame_to_write}) (#{Thread.current})" }
          frams_as_string = frame_to_write.as_string
          LOGGER.debug(THREAD_NAME) { "Frame as string: '#{frams_as_string}'" }
          result = output_buffer.write_nonblock(frams_as_string)
          LOGGER.debug(THREAD_NAME) { "Transmit success => #{result}" }
          return true if result
          retransmit(output_buffer, frams_as_string)
        end

        def retransmit(output_buffer, frame_to_write)
          LOGGER.debug(THREAD_NAME) { "#retransmit(output_buffer, frame)" }
          attempts = 1

          LOGGER.debug(THREAD_NAME) { "Enter retransmission cycle..." }
          until result || attempts > MAX_RETRY do
            LOGGER.debug(THREAD_NAME) { "Retry #{attempts} of #{MAX_RETRY}" }
            back_off = Random.rand * attempts
            LOGGER.debug(THREAD_NAME) { "Retry back off: #{back_off}" }
            sleep(back_off)
            result = output_buffer.write(frame_to_write)
            LOGGER.debug(THREAD_NAME) { "Retry result = #{result}" }
            attempts += 1
          end

          return true if result

          # LOGGER.error(THREAD_NAME) { "Retransmission failed after #{attempts} attempts!" }
          raise TransmissionError, "Retransmission failed after #{attempts} attempts!"
          return false
        end
      end
    end
  end
end
