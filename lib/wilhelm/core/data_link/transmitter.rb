# frozen_string_literal: false

module Wilhelm
  module Core
    module DataLink
      # Comment
      class Transmitter
        include Observable

        PROG_NAME = 'Transmitter'.freeze
        THREAD_NAME = PROG_NAME
        MAX_RETRY = 3

        attr_reader :threads, :write_queue

        alias frame_output_buffer write_queue

        def initialize(output_buffer, write_queue = Queue.new)
          @output_buffer = output_buffer
          @write_queue = write_queue
          @threads = ThreadGroup.new
        end

        def name
          PROG_NAME
        end

        def off
          LOGGER.debug(PROG_NAME) { "#{self.class}#off" }
          close_threads
        end

        def disable
          LOGGER.debug(PROG_NAME) { "#{self.class}#disable" }
          off
        end

        def on
          LOGGER.debug(PROG_NAME) { "#{self.class}#on" }
          begin
            write_thread = thread_write_buffer(@write_queue, @output_buffer)
            @threads.add(write_thread)
          rescue StandardError => e
            LOGGER.error(e)
            e.backtrace.each { |l| LOGGER.error(l) }
            raise e
          end
          true
        end

        private

        # ------------------------------ THREADS ------------------------------ #

        def close_threads
          LOGGER.debug "#{self.class}#close_threads"
          threads = @threads.list
          threads.each_with_index do |t, i|
            LOGGER.debug "Thread ##{i+1} / #{t.status}"
            t.exit.join
            LOGGER.debug "Thread ##{i+1} / #{t.status}"
          end
        end

        def thread_write_buffer(write_queue, output_buffer)
          LOGGER.debug(PROG_NAME) { 'New Thread: Frame Write.' }

          Thread.new do
            Thread.current[:name] = THREAD_NAME

            begin
              loop do
                begin
                  # frame_to_write = nil
                  LOGGER.debug(THREAD_NAME) { "Transmit queue length: #{write_queue.size}" }
                  LOGGER.debug(THREAD_NAME) { "Get next frame in queue... (blocking)" }
                  frame_to_write = write_queue.deq
                  # binding.pry
                  transmit(output_buffer, frame_to_write)
                rescue TransmissionError => e
                  LOGGER.error(THREAD_NAME) { e }
                  e.backtrace.each { |l| LOGGER.error(l) }
                rescue StandardError => e
                  LOGGER.error(THREAD_NAME) { e }
                  e.backtrace.each { |l| LOGGER.error(l) }
                end # begin
              end # loop
            rescue StandardError => e
              LOGGER.error(PROG_NAME) { "#{tn}: Exception: #{e}" }
              e.backtrace.each { |l| LOGGER.error(l) }
              binding.pry
            end
            LOGGER.warn(SYNC_ERROR) { "#{self.class} thread is finished..!" }
          end # thread_w
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
