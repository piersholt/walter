# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        module GPS
          class Coordinates < Base
            # Virtual::Command::GPS::Time
            module Time
              Clock = Struct.new(:hour, :minute, :second)

              def time
                @time ||=
                  Clock.new(
                    ptime(:hour),
                    ptime(:minute),
                    ptime(:second)
                  )
              end

              def format_time
                "#{ftime(:hour)}#{TIME_DELIMITER}" \
                "#{ftime(:minute)}#{TIME_DELIMITER}" \
                "#{ftime(:second)}"
              end

              def ptime(element)
                case element
                when :hour
                  parse(*hour.calculated)
                when :minute
                  parse(*minute.calculated)
                when :second
                  parse(*second.calculated)
                end
              end

              def ftime(element)
                case element
                when :hour
                  format(TIME_MASK, ptime(:hour))
                when :minute
                  format(TIME_MASK, ptime(:minute))
                when :second
                  format(TIME_MASK, ptime(:second))
                end
              end
            end
          end
        end
      end
    end
  end
end
