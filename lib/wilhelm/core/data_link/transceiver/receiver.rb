# frozen_string_literal: true

module Wilhelm
  module Core
    # Comment
    class Receiver
      include Observable
      include ManageableThreads

      NAME = 'Receiver'
      THREAD_NAME = 'Receiver'

      SYNC = 'Sync /'
      SYNC_HEADER = 'Header /'
      SYNC_TAIL = 'Tail /'
      SYNC_VALIDATION = 'Validate /'
      SYNC_ERROR = 'Error /'
      SYNC_SHIFT = 'Unshift! /'

      attr_reader :input_buffer, :frame_input_buffer, :read_thread

      def initialize(input_buffer, frame_synchronisation = FrameSynchronisation)
        @input_buffer = input_buffer
        @frame_input_buffer = SizedQueue.new(32)
        @frame_synchronisation = frame_synchronisation
      end

      def name
        NAME
      end

      # @override: ManageableThreads#proc_name
      alias proc_name name

      def off
        LogActually.datalink.debug(name) { "#{self.class}#off" }
        close_threads
      end

      def on
        LogActually.datalink.debug(name) { "#{self.class}#on" }
        @read_thread = thread_read_buffer(@input_buffer, @frame_input_buffer)
        add_thread(@read_thread)
        true
      rescue StandardError => e
        LogActually.datalink.error(e)
        e.backtrace.each { |l| LogActually.datalink.error(l) }
        raise e
      end

      private

      # ------------------------------ THREADS ------------------------------ #

      def thread_read_buffer(buffer, frame_input_buffer)
        Thread.new do
          LogActually.datalink.debug(name) { 'New Thread: Frame Synchronisation.' }
          Thread.current[:name] = THREAD_NAME
          synchronisation(buffer)
          LogActually.datalink.warn(name) { "#{self.class} thread is finished..!" }
        end
      end

      def synchronisation(buffer)
        LogActually.datalink.debug(name) { 'Entering byte shift loop.' }
        shift_count = 1
        loop do
          # LogActually.datalink.debug(name) { "#{shift_count}. Start." }
          synchronise_frame(buffer)
          # LogActually.datalink.debug(name) { "#{shift_count}. End." }
          shift_count += 1
        end
      rescue StandardError => e
        LogActually.datalink.error(name) { "#{SYNC_ERROR} Shift thread exception..! #{e}" }
        e.backtrace.each { |l| LogActually.datalink.error(l) }
        binding.pry
      end

      def synchronise_frame(buffer)
        synchronisation = @frame_synchronisation.new(buffer)
        new_frame = synchronisation.run

        LogActually.datalink.debug(name) { "#{Constants::Events::FRAME_RECEIVED}: #{new_frame}" }
        # reset_interval
        # output(new_frame)
        changed
        notify_observers(Constants::Events::FRAME_RECEIVED, frame: new_frame)

        frame_input_buffer.push(new_frame)
      rescue HeaderValidationError, HeaderImplausibleError, TailValidationError, ChecksumError => e
        LogActually.datalink.warn(name) { "#{e}!" }
        clean_up(buffer, synchronisation.frame)
      rescue StandardError => e
        LogActually.datalink.error(name) { e }
        e.backtrace.each { |line| LogActually.datalink.warn(line) }
        clean_up(buffer, synchronisation.frame)
        binding.pry
      end

      def clean_up(buffer, new_frame)
        LogActually.datalink.debug(name) { "#{SYNC_ERROR} #clean_up" }

        # LogActually.datalink.debug(SYNC_ERROR) { "Publishing event: #{Constants::Events::FRAME_FAILED}" }
        # changed
        # notify_observers(Constants::Events::FRAME_FAILED, frame: new_frame)

        # LogActually.datalink.debug(name) { "#{SYNC_SHIFT} Shifting one byte." }

        byte_to_discard = new_frame[0]
        LogActually.datalink.warn(name) { "#{SYNC_SHIFT} Drop: #{byte_to_discard}." }

        bytes_to_unshift = new_frame[1..-1]
        bytes_to_unshift = Bytes.new(bytes_to_unshift)
        LogActually.datalink.debug(name) { "#{SYNC_SHIFT} Returning to buffer: #{bytes_to_unshift.length} bytes." }
        LogActually.datalink.debug(name) { "#{SYNC_SHIFT} Returning to buffer: #{bytes_to_unshift.first(10)}....." }

        # LogActually.datalink.debug(name) { "#{SYNC_SHIFT} ..." }
        buffer.unshift(*bytes_to_unshift)
      end

      IGNORE = [0x40, 0xA0]

      def output(new_frame)
        wrapped_frame = PBus::Frame::Adapter.wrap(new_frame)
        LogActually.datalink.info(name) { "#{wrapped_frame}" } unless IGNORE.any? { |i| i == new_frame[0].d }
      end
    end
  end
end
