# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module RDSDisplay
            # RDSDisplay::Quick
            module Quick
              include API
              include Constants
              include Wilhelm::Helpers::DataTools

              # Title 11 chars
              def title(
                gfx: LAYOUT_HEADER,
                ike: 0b0001_0000,
                chars: genc(LENGTH_TITLE)
              )
                # padded_chars = pad_chars(chars, LENGTH_TITLE)
                padded_chars = chars
                draw_23(gfx: gfx, ike: ike, chars: padded_chars)
              end

              # Subtitles 20 chars
              def h2(
                layout: LAYOUT_HEADER,
                padding: PADDING_NONE,
                zone: INDEX_FIELD_6,
                chars: genc(LENGTH_SUBHEADING)
              )
                padded_chars = pad_chars(chars, LENGTH_SUBHEADING)
                draw_a5(layout: layout, padding: padding, zone: zone, chars: padded_chars)
              end

              # Subtitles 20 chars
              def h3(
                layout: LAYOUT_HEADER,
                padding: PADDING_NONE,
                zone: INDEX_FIELD_7,
                chars: genc(LENGTH_SUBHEADING)
              )
                padded_chars = pad_chars(chars, LENGTH_SUBHEADING)
                draw_a5(layout: layout, padding: padding, zone: zone, chars: padded_chars)
              end

              def a1(
                layout: LAYOUT_HEADER,
                padding: PADDING_NONE,
                zone: INDEX_FIELD_1,
                chars: genc(LENGTH_A)
              )
                padded_chars = pad_chars(chars, LENGTH_A)
                draw_a5(layout: layout, padding: padding, zone: zone, chars: padded_chars)
              end

              def a2(
                layout: LAYOUT_HEADER,
                padding: PADDING_NONE,
                zone: INDEX_FIELD_2,
                chars: genc(LENGTH_A)
              )
                draw_a5(layout: layout, padding: padding, zone: zone, chars: chars)
              end

              def a3(
                layout: LAYOUT_HEADER,
                padding: PADDING_NONE,
                zone: INDEX_FIELD_3,
                chars: genc(LENGTH_A)
              )
                draw_a5(layout: layout, padding: padding, zone: zone, chars: chars)
              end

              def b1(
                layout: LAYOUT_HEADER,
                padding: PADDING_NONE,
                zone: INDEX_FIELD_4,
                chars: genc(LENGTH_B)
              )
                draw_a5(layout: layout, padding: padding, zone: zone, chars: chars)
              end

              def b2(
                layout: LAYOUT_HEADER,
                padding: PADDING_NONE,
                zone: INDEX_FIELD_5,
                chars: genc(LENGTH_B)
              )
                draw_a5(layout: layout, padding: padding, zone: zone, chars: chars)
              end
            end
          end
        end
      end
    end
  end
end
