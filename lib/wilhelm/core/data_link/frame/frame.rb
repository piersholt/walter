# frozen_string_literal: false

module Wilhelm
  module Core
    # Comment
    class ChecksumError < StandardError
    end

    # Comment
    class Frame < Bytes
      PROG_NAME = 'Frame'.freeze
      HEADER_LENGTH = 2
      HEADER_INDEX_LENGTH = 2

      FrameHeader.instance_methods(false).each do |header_method|
        def_delegator :header, header_method
      end

      FrameTail.instance_methods(false).each do |tail_method|
        def_delegator :tail, tail_method
      end

      # ************************************************************************* #
      #                                  OBJECT
      # ************************************************************************* #

      def initialize(bytes = [])
        super(bytes)
      end

      def to_s
        map(&:h).join(' ').to_s
      end

      def inspect
        "<Frame> #{to_s}"
      end

      # ************************************************************************* #
      #                                  FRAME
      # ************************************************************************* #

      def header
        @header ||= Bytes.new
      end

      def tail
        @tail ||= Bytes.new
      end

      def set_header(new_header)
        LOGGER.debug(PROG_NAME) { "#set_header(#{new_header})." }

        # LOGGER.debug(PROG_NAME) { "Updating self with bytes." }
        wholesale(new_header + tail)
        # LOGGER.debug(PROG_NAME) { self }

        # LOGGER.debug(PROG_NAME) { "Setting @header." }
        @header = FrameHeader.new(new_header)

        true
      end

      def set_tail(new_tail)
        LOGGER.debug(PROG_NAME) { "#set_tail(#{new_tail})." }

        # LOGGER.debug(PROG_NAME) { "Updating self with bytes." }
        wholesale(header + new_tail)
        # LOGGER.debug(PROG_NAME) { self }

        # LOGGER.debug(PROG_NAME) { "Setting @tail." }
        @tail = FrameTail.new(new_tail)

        true
      end

      # ************************************************************************* #
      #                                  FRAME
      # ************************************************************************* #

      def valid?
        LOGGER.debug(PROG_NAME) { "#valid?" }
        raise ArgumentError, '@header or @tail is empty!' if header.empty? || tail.empty?

        LOGGER.debug(PROG_NAME) { "@header => #{@header}" }
        LOGGER.debug(PROG_NAME) { "@tail.no_fcs => #{@tail.no_fcs}" }

        frame_bytes = @header + @tail.no_fcs
        checksum = frame_bytes.reduce(0) do |c,d|
          c^= d.to_d
        end

        LOGGER.debug(PROG_NAME) { "Checksum / #{tail.checksum} == #{checksum} => #{checksum == tail.checksum}" }

        checksum == tail.checksum
      rescue TypeError => e
        LOGGER.error(name) { e.class }
        LOGGER.error(name) { e }
        e.backtrace.each { |l| LOGGER.warn(l) }
        binding.pry
        LOGGER.warn(name) { 'Debug end...'}
      end
    end
  end
end
