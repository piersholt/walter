module PBus
  class Frame
    class Adapter
      include Wilhelm::Core::DataTools
      extend Forwardable
      def_delegators :@frame, :command

      C_MAP = {
        0x10 => :vehicle_state,
        0x11 => :driver_window_state,
        0x12 => :driver_window_state_and_control,
        0x13 => :sunroof_control,
        0x14 => :master_window_control,

        # 0x20 => :unknown_20,
        0x21 => :memory_driver,
        0x22 => :memory_passenger,
        0x24 => :mirror_control,

        0x30 => :central_locking,

        0x40 => :unknown_40,
        # 0x80 => :unknown_80,

        0xA0 => :confirm,
        0xB0 => :gm_consumer,
        0xF1 => :diag_mem_passenger,
        0xF2 => :diag_mem_passenger
      }.freeze

      # 0x11
      DRIVER_WINDOW_BITS = {
        3 => :window_driver_front_closed
      }

      # 0x12
      PASS_WINDOW_BITS = {
        3 => :window_passenger_front_closed
      }

      MEMORY_DRIVER = {
        0x01 => :preset_1,
        0x02 => :preset_2,
        0x03 => :preset_3,
        0x04 => :complete
      }

      # 0x10
      # BYTE 1
      VEHICLE_BITS = {
        6 => :door_driver_rear_open,
        5 => :door_passenger_front_open,
        4 => :door_driver_front_open,
        1 => :ignition_2,
        0 => :gear_park
      }

      # BYTE 2
      SECURITY_BITS = {

      }

      # LOCK
      # keyless lock
      # 1110_0000 as I was locking
      # 0010_0000 after the 'click'
      # auto re-lock
      # 01000000

      # UNLOCK
      # 1000_0100 0x84 first remote unlock
      # 1000_0000 0x80 full un lock

      # 0000_0100 0x04 second stage 1
      # 1000_0000 0x80 second stage 2

      # for both unlocks stage 1.. bit 3 is 1
      # 1000_0100 0x84 first remote unlock
      # 0000_0100 0x04 second unlock

      # 0x14 BYTE 1
      DRIVER_WINDOW_CONTROL = {
        0x00 => :zero_state,
        0b0000_0001 => :down_manual,
        0b0000_0010 => :up_manual,
        0b0000_0101 => :down_auto,
        0b0000_0110 => :up_auto,
        0b0000_1000 => :rear_down_manual,
        0b0010_1000 => :rear_down_auto,
        0b0001_0000 => :rear_up_manual,
        0x30 => :rear_up_auto,
        0x40 => :child_lock
      }.freeze

      # 0x14 BYTE 2
      PASSENGER_WINDOW_CONTROL = {
        0x00 => :zero_state,
        0x01 => :down_manual,
        0x05 => :down_auto,
        0x02 => :up_manual,
        0x06 => :up_auto,
        0x08 => :rear_down_manual,
        0x28 => :rear_down_auto,
        0x10 => :rear_up_manual,
        0x30 => :rear_up_auto
      }.freeze

      # 0x24
      MIRROR_CONTROL = {
        0x00 => :zero_state,
        0x01 => :driver_up,
        0x02 => :driver_down,
        0x04 => :driver_out,
        0x08 => :driver_in,
        0x10 => :passenger_select,
        0x11 => :passenger_up,
        0x12 => :passenger_down,
        0x14 => :passenger_in,
        0x18 => :passenger_out
      }.freeze

      def self.wrap(frame)
        Adapter.new(frame)
      end

      def initialize(frame)
        @frame = frame
      end

      def to_s
        "#{command} #{arguments} #{fcs}"
      end

      def diag?
        # @frame[2].value == 0x0c
        @frame[1].value = @frame.length
      end

      def vc?
        @frame[2].value == 0x0c
      end

      def command?
        index = @frame[0].value
        C_MAP.key?(index)
      end

      def command
        return @frame[0] unless command?
        C_MAP[@frame[0].value]
      end

      def arguments
        return payload unless command?
        return payload unless self.respond_to?(command)
        public_send(command)
      end

      def payload
        # @frame[1..-2].map { |b| BitArray.from_i(b.value) }
        @frame[1..-2].map(&:h)
      end

      def fcs
        @frame[-1..-1]
      end

      def mirror_control
        mirror_control = @frame[1]
        unused = @frame[2]
        m_index = mirror_control.value
        { mirror_control => MIRROR_CONTROL[m_index],
          unused: unused }
      end

      def master_window_control
        driver_window_control = @frame[1]
        passenger_window_control = @frame[2]
        d_index = driver_window_control.value
        p_index = passenger_window_control.value
        { driver_window_control: DRIVER_WINDOW_CONTROL[d_index],
          passenger_window_control: PASSENGER_WINDOW_CONTROL[p_index] }
      end
    end
  end
end
