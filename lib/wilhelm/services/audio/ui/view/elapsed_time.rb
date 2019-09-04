# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class UserInterface
        module View
          # Audio::UserInterface::View::NowPlaying
          class ElapsedTime
            include SDK::UIKit::View
            include Helpers::Time

            BARS_MAX       = 24
            FILL_CHAR      = 0xb7.chr
            HEAD_CHAR      = 0x82.chr
            EMPTY_CHAR     = 0xb7.chr
            BOUNDARY_LEFT  = 0xab.chr
            BOUNDARY_RIGHT = 0xbb.chr

            attr_reader :label

            def initialize(elapsed_time = 0, duration = 10)
              duration = 1 if duration.zero?
              elapsed_time = 0 if elapsed_time >= duration
              @label = generate(elapsed_time, duration)
            end

            def to_s
              label
            end

            def to_c
              label.bytes
            end

            private

            def generate(a, b)
              percentage = proportion(a, b) * BARS_MAX
              fill = percentage.round(0)
              fill_chars = Array.new(fill.zero? ? 0 : fill - 1, FILL_CHAR) << HEAD_CHAR

              empty = BARS_MAX - fill
              empty_chars = Array.new(empty.negative? ? 0 : empty, EMPTY_CHAR)

              "#{BOUNDARY_LEFT}#{(fill_chars + empty_chars).join}#{BOUNDARY_RIGHT}"
            rescue StandardError => e
              LogActually.services.error(self.class) { "#{e}: a=#{a}, b=#{b}" }
              raise e
            end

            def proportion(a, b, precision = 2)
              a.fdiv(b).round(precision)
            end
          end
        end
      end
    end
  end
end
