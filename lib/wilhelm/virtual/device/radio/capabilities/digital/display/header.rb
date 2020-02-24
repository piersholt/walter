# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module RDS
            module Display
              # RDS::Display::Header
              module Header
                include API
                include Constants

                def generate_header_a5
                  LAYOUT_INDICES[DIGITAL_HEADER].each_with_index do |zone_index, index|
                    draw_row_a5(
                      DIGITAL_HEADER,
                      PADDING_NONE,
                      zone_index | BLOCK | (index.zero? ? FLUSH : 0),
                      generate_a5(DIGITAL_HEADER, PADDING_NONE, zone_index)
                    )
                  end
                  # render(DIGITAL_HEADER)
                  title
                end

                # BM23
                # This doesn't seem to work at all on widescreen BMBT?
                def generate_header_21
                  LAYOUT_INDICES[DIGITAL_HEADER].each_with_index do |zone_index, index|
                    draw_row_21(
                      DIGITAL_HEADER,
                      ZERO,
                      zone_index | BLOCK | (index.zero? ? FLUSH : 0),
                      generate_21(DIGITAL_HEADER, ZERO, zone_index)
                    )
                  end
                  title
                end

                # Title 11 chars
                def title(
                  gt: DIGITAL_HEADER,
                  ike: 0b0001_0000,
                  chars: gens(LENGTH_TITLE)
                )
                  draw_23(
                    gt: gt,
                    ike: ike,
                    chars: chars
                  )
                end

                # 5 chars
                def a1(chars: pad_chars(gens(LENGTH_5), LENGTH_5))
                  draw_a5(
                    layout:   DIGITAL_HEADER,
                    padding:  PADDING_NONE,
                    zone:     INDEX_1,
                    chars:    chars
                  )
                end

                # 5 chars
                def a2(chars: pad_chars(gens(LENGTH_5), LENGTH_5))
                  draw_a5(
                    layout:   DIGITAL_HEADER,
                    padding:  PADDING_NONE,
                    zone:     INDEX_2,
                    chars:    chars
                  )
                end

                # 5 chars
                def a3(chars: pad_chars(gens(LENGTH_5), LENGTH_5))
                  draw_a5(
                    layout:   DIGITAL_HEADER,
                    padding:  PADDING_NONE,
                    zone:     INDEX_3,
                    chars:    chars
                  )
                end

                # 7 chars
                def b1(chars: pad_chars(gens(LENGTH_7), LENGTH_7))
                  draw_a5(
                    layout:   DIGITAL_HEADER,
                    padding:  PADDING_NONE,
                    zone:     INDEX_4,
                    chars:    chars
                  )
                end

                # 7 chars
                def b2(chars: pad_chars(gens(LENGTH_7), LENGTH_7))
                  draw_a5(
                    layout:   DIGITAL_HEADER,
                    padding:  PADDING_NONE,
                    zone:     INDEX_5,
                    chars:    chars
                  )
                end

                # Subtitles 20 chars
                def h2(chars: pad_chars(gens(LENGTH_20), LENGTH_20))
                  draw_a5(
                    layout:   DIGITAL_HEADER,
                    padding:  PADDING_NONE,
                    zone:     INDEX_6,
                    chars:    chars
                  )
                end

                # Subtitles 20 chars
                def h3(chars: pad_chars(gens(LENGTH_20), LENGTH_20))
                  draw_a5(
                    layout:   DIGITAL_HEADER,
                    padding:  PADDING_NONE,
                    zone:     INDEX_7,
                    chars:    chars
                  )
                end
              end
            end
          end
        end
      end
    end
  end
end
