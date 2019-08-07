# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      # Virtual::Command::CCMDisplay
      class CCMDisplay < Base
        include Helpers::DataTools
        attr_accessor :mode, :control, :chars

        def inspect
          "#{sn}\t" \
          "#{d2h(mode.value, true)} (#{mode}) | " \
          "#{d2h(control.value, true)} (#{control})\t" \
          "#{chars}"
        end

        def to_s
          "#{sn}\t" \
          "#{d2h(mode.value, true)} (#{mode}) | " \
          "#{d2h(control.value, true)} (#{control})\t" \
          "#{chars}"
        end
      end
    end
  end
end
