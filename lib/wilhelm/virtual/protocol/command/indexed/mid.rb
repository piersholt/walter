# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      module Indexed
        # Virtual::Command::MID
        class MID < Base
          include Wilhelm::Helpers::PositionalNotation
          def to_s
            "#{sn}\t#{@layout}, #{@m2}, #{@m3}, #{@chars}"
          end

          def inspect
            to_s
          end

          def index
            @m3
          end
        end

        class MID < Base
          # Virtual::Command::MID::Radio
          class Radio < MID
            LAYOUT_MENU_A = 0x6_0 # SIMPLE MENU
            LAYOUT_MENU_B = 0x6_1 # MENU WITH HEADER
            LAYOUT_HEADER = 0x6_2
            LAYOUT_STATIC = 0x6_3
            
            # layout:, options: chars:
            def initialize(id, props, layout:, options:, chars:)
              super
            end
          end

          # Virtual::Command::MID::Telephone
          class Telephone < MID
            # 0x43 m2[:band]
            # 0x41 m2[:preset]
            # 0x83 m2[:dolby]

            LAYOUT_DEFAULT   = 0x0_0
            LAYOUT_PIN       = 0x0_5
            LAYOUT_INFO      = 0x2_0
            LAYOUT_DIAL      = 0x4_2
            LAYOUT_DIRECTORY = 0x4_3
            LAYOUT_TOP_8     = 0x8_0
            LAYOUT_SMS_INDEX = 0xf_0
            LAYOUT_SMS_SHOW  = 0xf_1

            FUNCTION_MAP = {
              LAYOUT_DEFAULT   => :layout_default,
              LAYOUT_PIN       => :layout_pin,
              LAYOUT_INFO      => :layout_info,
              LAYOUT_DIAL      => :layout_dial,
              LAYOUT_DIRECTORY => :layout_directory,
              LAYOUT_TOP_8     => :layout_top_8,
              LAYOUT_SMS_INDEX => :layout_sms_index,
              LAYOUT_SMS_SHOW  => :layout_sms_show
            }.freeze

            def initialize(id, props, layout:, options:, chars:)
              super
              @layout = base256(*layout)
              @options = base256(*options)
              @chars = chars

              public_send(FUNCTION_MAP.fetch(layout), options)
            end

            # def layout
            #   @layout
            # end
            #
            # def index
            #   parse_base_2(*@options[11..15])
            # end

            def layout_default(options)
              puts "layout_default(#{options})"
            end

            def layout_pin(options)
              puts "layout_pin(#{options})"
            end

            def layout_info(options)
              puts "layout_info(#{options})"
            end

            def layout_dial(options)
              puts "layout_dial(#{options})"
            end

            def layout_directory(options)
              puts "layout_directory(#{options})"
            end

            def layout_top_8(options)
              puts "layout_top_8(#{options})"
            end

            def layout_sms_index(options)
              puts "layout_sms_index(#{options})"
            end

            def layout_sms_show(options)
              puts "layout_sms_show(#{options})"
            end
          end
      end
      end
    end
  end
end
