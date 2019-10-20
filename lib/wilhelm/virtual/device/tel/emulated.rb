# frozen_string_literal: true

require_relative 'emulated/state'
require_relative 'emulated/mock'
require_relative 'emulated/common'
require_relative 'emulated/dial'
require_relative 'emulated/directory'
require_relative 'emulated/last_numbers'
require_relative 'emulated/top_8'
require_relative 'emulated/received'
require_relative 'emulated/default'
require_relative 'emulated/info'
require_relative 'emulated/pin'
require_relative 'emulated/sms'
require_relative 'emulated/sos'

module Wilhelm
  module Virtual
    class Device
      module Telephone
        # Telephone::Emulated
        class Emulated < Device::Emulated
          include Wilhelm::Helpers::DataTools
          include Virtual::Constants::Command::Groups
          include Capabilities
          include State
          include Mock
          include Common
          include Directory
          include Top8
          include Dial
          include LastNumbers
          include Default
          include Info
          include PIN
          include SMS
          include SOS
          include Received

          PROC = 'Telephone::Emulated'

          SUBSCRIBE = [
            PING, PONG,
            IGNITION_REP,
            TEL_OPEN,
            INPUT,
            MFL_VOL, MFL_FUNC,
            BMBT_A,
            COORD, ADDR, ASSIST
          ].freeze

          LogActually.is_all_around(:tel)
          LogActually.tel.d

          def logger
            LogActually.tel
          end

          def handle_virtual_receive(message)
            command_id = message.command.d
            return false unless subscribe?(command_id)
            case command_id
            when PONG
              # logger.debug(PROC) { "Rx: PONG 0x#{d2h(PONG)}" }
              handle_pong(message)
            when INPUT
              logger.debug(PROC) { "Rx: INPUT 0x#{d2h(INPUT)}" }
              handle_input(message.command)
            when TEL_OPEN
              logger.debug(PROC) { "Rx: TEL_OPEN 0x#{d2h(TEL_OPEN)}" }
              handle_tel_open(message)
            when MFL_VOL
              logger.debug(PROC) { "Rx: MFL_VOL 0x#{d2h(MFL_VOL)}" }
              handle_mfl_vol(message.command)
            when MFL_FUNC
              logger.debug(PROC) { "Rx: MFL_FUNC 0x#{d2h(MFL_FUNC)}" }
              handle_mfl_func(message.command)
            when BMBT_A
              logger.debug(PROC) { "Rx: BMBT_A 0x#{d2h(BMBT_A)}" }
              handle_bmbt_button_1(message.command)
            when COORD
              logger.debug(PROC) { "Rx: COORD 0x#{d2h(COORD)}" }
              handle_telematics_coord(message.command)
            when ADDR
              logger.debug(PROC) { "Rx: ADDR 0x#{d2h(ADDR)}" }
              handle_telematics_addr(message.command)
            when ASSIST
              logger.debug(PROC) { "Rx: ASSIST 0x#{d2h(ASSIST)}" }
              false
            end

            super(message)
          end

          # @override Device::Capabilities::Ready.pong
          def pong
            super(to: :glo_h, status: 0x30)
          end

          # @override Device::Capabilities::Ready.announce
          def announce
            super(to: :glo_h, status: 0x30)
          end
        end
      end
    end
  end
end
