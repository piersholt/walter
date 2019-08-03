# frozen_string_literal: false

puts "\tLoading wilhelm/core/data_link/frame"

require_relative 'frame/header'
require_relative 'frame/tail'
require_relative 'frame/builder'

module Wilhelm
  module Core
    module DataLink
      # Comment
      class Frame < Bytes
        NAME = 'Frame'.freeze
        HEADER_LENGTH = 2
        HEADER_INDEX_LENGTH = 2

        Header.instance_methods(false).each do |header_method|
          def_delegator :header, header_method
        end

        Tail.instance_methods(false).each do |tail_method|
          def_delegator :tail, tail_method
        end

        # ************************************************************************* #
        #                                  OBJECT
        # ************************************************************************* #

        def initialize(bytes = [])
          super(bytes)
        end

        def inspect
          "<Frame> #{to_s}"
        end

        # ************************************************************************* #
        #                                  FRAME
        # ************************************************************************* #

        def header
          @header ||= create_header
        end

        def create_header
          Bytes.new
        end

        def tail
          @tail ||= create_tail
        end

        def create_tail
          Bytes.new
        end

        def set_header(new_header)
          LOGGER.debug(NAME) { "#set_header(#{new_header})." }

          # LOGGER.debug(NAME) { "Updating self with bytes." }
          wholesale(@tail ? new_header + tail : new_header)
          # LOGGER.debug(NAME) { self }

          # LOGGER.debug(NAME) { "Setting @header." }
          @header = Header.new(new_header)

          true
        end

        def set_tail(new_tail)
          LOGGER.debug(NAME) { "#set_tail(#{new_tail})." }

          # LOGGER.debug(NAME) { "Updating self with bytes." }
          wholesale(header + new_tail)
          # LOGGER.debug(NAME) { self }

          # LOGGER.debug(NAME) { "Setting @tail." }
          @tail = Tail.new(new_tail)

          true
        end

        # ************************************************************************* #
        #                                  FRAME
        # ************************************************************************* #

        def valid?
          LOGGER.debug(NAME) { "#valid?" }
          raise ArgumentError, '@header or @tail is empty!' if header.empty? || tail.empty?

          LOGGER.debug(NAME) { "@header => #{@header}" }
          LOGGER.debug(NAME) { "@tail.no_fcs => #{@tail.no_fcs}" }

          frame_bytes = @header + @tail.no_fcs
          checksum = frame_bytes.reduce(0) do |c, d|
            c ^ d
          end

          LOGGER.debug(NAME) { "Checksum / #{tail.checksum} == #{checksum} => #{checksum == tail.checksum}" }

          checksum == tail.checksum
        rescue TypeError => e
          LOGGER.error(NAME) { e.class }
          LOGGER.error(NAME) { e }
          e.backtrace.each { |l| LOGGER.warn(l) }
          binding.pry
          LOGGER.warn(NAME) { 'Debug end...'}
        end
      end
    end
  end
end
