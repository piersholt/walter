# frozen_string_literal: false

module Wilhelm
  module Core
    # DebugTools
    # Helpers for common tasks on CLI
    module DebugTools
      PROC_MOD = 'DebugTools'.freeze
      include Command::Groups

      # Defaults

      def apply_debug_defaults
        LOGGER.info(PROC_MOD) { 'Applying debug defaults.' }
        shutup!
      end

      # Session

      def messages
        SessionHandler.i.messages
      end

      # def d
      #   instance_variable_get(:@virtual_display)
      # end

      # DisplayHandler

      def s
        DisplayHandler.instance.enable
      end

      def h
        DisplayHandler.instance.disable
      end

      # DisplayHandler FILTERING

      def c
        DisplayHandler.i.clear_filter
      end

      def shutup!(set = NOISEY_NG)
        set.each do |group, command_ids|
          LOGGER.debug { "Shutting up: #{group}" }
          DisplayHandler.i.h_c(*command_ids)
        end
      end

      def touch!
        DisplayHandler.i.h_c(*BUTTON)
      end

      def mid!
        DisplayHandler.i.h_c(*MID)
      end

      alias shh! shutup!

      def ready
        DisplayHandler.i.filter_commands(*READY)
      end

      def buttons
        DisplayHandler.i.filter_commands(*BUTTON)
      end

      def menus
        DisplayHandler.i.filter_commands(*MENUS)
      end

      def diag
        DisplayHandler.i.filter_commands(*DIAGNOSTICS)
      end

      def obc
        DisplayHandler.i.filter_commands(*OBC)
      end

      def ign
        DisplayHandler.i.filter_commands(*IGNITION)
      end

      def tel
        DisplayHandler.i.f_t(*Device::Groups::TELEPHONE + Device::Groups::BROADCAST)
        DisplayHandler.i.f_f(*Device::Groups::TELEPHONE)
        DisplayHandler.i.h_c(
          *SPEED, *TEMPERATURE, *COUNTRY, *VEHICLE, *LAMP,
          *SENSORS, *OBC, *READY, *IGNITION
        )
        DisplayHandler.i.h_c(RAD_LED, SRC_CTL, SRC_SND, MENU_GFX, MENU_RAD)
      end

      def nav
        DisplayHandler.i.f_t(*Device::Groups::NAV)
        DisplayHandler.i.f_f(*Device::Groups::NAV)
        DisplayHandler.i.h_c(
          *SPEED, *TEMPERATURE, *VEHICLE, *LAMP,
          *SENSORS, *OBC, *IGNITION
        )
      end

      def cdc
        DisplayHandler.i.f_t(*Device::Groups::CD)
        DisplayHandler.i.f_f(*Device::Groups::CD)
        DisplayHandler.i.h_c(
          *READY, *SPEED, *TEMPERATURE, *COUNTRY,
          *VEHICLE, *LAMP, *SENSORS, *OBC, *IGNITION
        )
      end

      def cdc!
        DisplayHandler.i.f_t(*Device::Groups::CD)
        DisplayHandler.i.f_f(*Device::Groups::CD)
        DisplayHandler.i.h_c(
          *READY, *SPEED, *TEMPERATURE, *COUNTRY,
          *VEHICLE, *LAMP, *SENSORS, *OBC, *IGNITION
        )

        DisplayHandler.i.h_c(*DISPLAY, *BUTTON)
      end

      def media
        DisplayHandler.i.f_t(*Device::Groups::MEDIA + BROADCAST)
        DisplayHandler.i.f_f(*Device::Groups::MEDIA)
      end

      # Logging

      # def debug
      #   LOGGER.sev_threshold=(Logger::DEBUG)
      # end
      #
      # def info
      #   LOGGER.sev_threshold=(Logger::INFO)
      # end

      # Annoying Tasks :)

      def hello?
        t0 = messages.count
        Kernel.sleep(1)
        t1 = messages.count
        r = t1 - t0
        LOGGER.info(PROC_MOD) { "#{r} new messages in the last second." }
        r.positive? ? true : false
      end

      def news
        print_status(true)
        true
      end

      def nl
        new_line_thread = Thread.new do
          Thread.current[:name] = 'New Line'
          Kernel.sleep(0.5)
          LOGGER.unknown('Walter') { 'New Line' }
        end
        add_thread(new_line_thread)
      end

      # Delay

      def nap(seconds)
        # @interface.read_thread[:sleep_time] = seconds
        @interface.read_thread.thread_variable_set(:sleep_time, seconds)
      end

      def sleepy?
        # @interface.read_thread[:sleep_enabled] = false
        @interface.read_thread.thread_variable_get(:sleep_enabled)
      end

      def awake!
        t = @interface.read_thread
        # @interface.read_thread[:sleep_enabled] = false
        t.thread_variable_set(:sleep_enabled, false)
        # puts "[#{t[:name]}] :sleep_enabled => #{sleepy?}"
      end

      def sleepy!
        t = @interface.read_thread
        # @interface.read_thread[:sleep_enabled] = true
        t.thread_variable_set(:sleep_enabled, true)
        # puts "[#{t[:name]}] :sleep_enabled => #{sleepy?}"
      end

      # Yabber

      LOG_LEVEL_MAP = {
        d: :debug,
        i: :info,
        w: :warn,
        e: :error
      }.freeze

      YABBER_LOGS = %i[messaging client publisher server subscriber].freeze

      def yap(level = :w)
        return false unless LOG_LEVEL_MAP.key?(level)
        YABBER_LOGS.each do |log|
          LOGGER.info('DebugTools') { "#{log} to #{LOG_LEVEL_MAP[level].upcase}" }
          LogActually.public_send(log)&.public_send(level)
        end
        true
      end
    end
  end
end
