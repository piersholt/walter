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
          CONSUMP_1   = 0x04
          CONSUMP_2   = 0x05
          RANGE       = 0x06
          DISTANCE    = 0x07
          ARRIVAL     = 0x08
          LIMIT       = 0x09
          AVG_SPEED   = 0x0a
          TIMER       = 0x0e
          TIMER_1     = 0x0f
          TIMER_2     = 0x10
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
            TIMER_1     => 'Timer 1',
            TIMER_2     => 'Timer 2',
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
            TIMER_1     => :timer_1,
            TIMER_2     => :timer_2,
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
