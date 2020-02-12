# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        # Command::Parameterized::MID::Telephone
        class Prog < Parameterized::Base
          class_variable_set(:@@configured, true)
          attr_accessor(:functions)

          TIME        = 0x01
          DATE        = 0x02
          # TEMPERATURE = 0x03
          CONSUMP_1   = 0x04
          CONSUMP_2   = 0x05
          RANGE       = 0x06
          DISTANCE    = 0x07
          ARRIVAL     = 0x08
          LIMIT       = 0x09
          AVG_SPEED   = 0x0a
          # PROG      = 0x0b  "PROG"
          # MEMO      = 0x0c
          # CODE      = 0x0d  "CODE"
          TIMER       = 0x0e
          AUX_TIMER_1 = 0x0f
          AUX_TIMER_2 = 0x10
          # HEAT_OFF  = 0x11
          # HEAT_ON   = 0x12
          # VENT_OFF  = 0x13
          # VENT_ON   = 0x14
          # CODE      = 0x16  "CODE"
          # TIMER_LAP = 0x1a  "STOPW"
          NO_FUNCTION = 0xff

          DICTIONARY = {
            TIME        => 'Time',
            DATE        => 'Date',
            CONSUMP_1   => 'Consump. 1',
            CONSUMP_2   => 'Consump. 2',
            RANGE       => 'Range',
            DISTANCE    => 'Distance',
            ARRIVAL     => 'Arrival',
            LIMIT       => 'Limit',
            AVG_SPEED   => 'Avg. Speed',
            TIMER       => 'Timer',
            AUX_TIMER_1 => '(Aux.) Timer 1',
            AUX_TIMER_2 => '(Aux.) Timer 2',
            NO_FUNCTION => nil
          }.freeze

          MAP = {
            TIME        => :time,
            DATE        => :date,
            CONSUMP_1   => :consump_1,
            CONSUMP_2   => :consump_2,
            RANGE       => :range,
            DISTANCE    => :distance,
            ARRIVAL     => :arrival,
            LIMIT       => :limit,
            AVG_SPEED   => :avg_speed,
            TIMER       => :timer,
            AUX_TIMER_1 => :aux_timer_1,
            AUX_TIMER_2 => :aux_timer_2,
            NO_FUNCTION => nil
          }.freeze

          # @override Base#format_things
          def format_things
            "#{functions.value} #{ugly}"
          end

          def pretty
            functions.value.map do |id|
              DICTIONARY[id]
            end&.compact&.join(', ')
          end

          def ugly
            functions.value.map do |id|
              MAP[id]
            end&.compact
          end
        end
      end
    end
  end
end
