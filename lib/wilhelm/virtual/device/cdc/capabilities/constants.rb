# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module CDC
        module Capabilities
          # Comment
          module Constants
            SCAN_THRESHOLD_SECONDS = 3

            # CONTROL 0x39
            CONTROL_STOPPED  = 0x00
            CONTROL_PLAYING_NEW = 0x01
            CONTROL_PLAYING  = 0x02
            CONTROL_FWD      = 0x03
            CONTROL_RWD      = 0x04
            CONTROL_NEXT     = 0x05
            CONTROL_PREVIOUS = 0x06
            CONTROL_PENDING  = 0x07
            CONTROL_READY    = 0x08
            CONTROL_CHECK    = 0x09
            CONTROL_EJECT    = 0x0a

            CONTROL = {
              stopped: CONTROL_STOPPED,
              playing_new: CONTROL_PLAYING_NEW,
              playing: CONTROL_PLAYING,
              fwd: CONTROL_FWD,
              rwd: CONTROL_RWD,
              next: CONTROL_NEXT,
              previous: CONTROL_PREVIOUS,
              pending: CONTROL_PENDING,
              ready: CONTROL_READY,
              check: CONTROL_CHECK,
              eject: CONTROL_EJECT
            }.freeze

            CONTROL_MAP = {
              CONTROL_STOPPED => :stopped,
              CONTROL_PLAYING_NEW => :playing_new,
              CONTROL_PLAYING => :playing,
              CONTROL_FWD => :fwd,
              CONTROL_RWD => :rwd,
              CONTROL_NEXT => :next,
              CONTROL_PREVIOUS => :previous,
              CONTROL_PENDING => :pending,
              CONTROL_READY => :ready,
              CONTROL_CHECK => :check,
              CONTROL_EJECT => :eject
            }.freeze

            # STATUS
            STATUS_IDLE = 0x02
            STATUS_ACTIVE = 0x09

            STATUS = {
              active: STATUS_ACTIVE,
              idle: STATUS_IDLE
            }.freeze

            STATUS_MAP = {
              STATUS_ACTIVE => :active,
              STATUS_IDLE => :idle
            }.freeze

            # MAGAZINE
            MAGAZINE_OK = 0x00
            MAGAZINE_ERROR = 0x08

            MAGAZINE = {
              ok: MAGAZINE_OK,
              error: MAGAZINE_ERROR
            }.freeze

            MAGAZINE_MAP = {
              MAGAZINE_OK => :ok,
              MAGAZINE_ERROR => :error
            }.freeze

            # LOADER
            LOADER_EMPTY = 0x0000_0000
            LOADER_ONE = 0x0000_0001
            LOADER_TWO = 0x0000_0011
            LOADER_THREE = 0x0000_0111
            LOADER_FOUR = 0x0000_1111
            LOADER_FIVE = 0x0001_1111
            LOADER_SIX = 0b0011_1111

            LOADER = {
              zero: LOADER_EMPTY,
              one: LOADER_ONE,
              two: LOADER_TWO,
              three: LOADER_THREE,
              four: LOADER_FOUR,
              five: LOADER_FIVE,
              six: LOADER_SIX
            }.freeze

            LOADER_MAP = {
              LOADER_EMPTY => :zero,
              LOADER_ONE => :one,
              LOADER_TWO => :two,
              LOADER_THREE => :three,
              LOADER_FOUR => :four,
              LOADER_FIVE => :five,
              LOADER_SIX => :six
            }.freeze
          end
        end
      end
    end
  end
end
