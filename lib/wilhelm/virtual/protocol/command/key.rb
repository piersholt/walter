# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      # Virtual::Command::Key
      class Key < Base
        # @override
        def to_s
          "#{sn}\t" \
          "#{key}: #{status}"
        end

        def inspect
          "#<#{self.class} " \
          "@key=#{key.value} (#{key}) "\
          "@status=#{status.value} (#{status})>"
        end
      end
    end
  end
end
