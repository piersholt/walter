# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Radio
        module Capabilities
          module RDSDisplay
            # RDSDisplay::Header
            module Header
              include API
              include Constants
              include Wilhelm::Helpers::DataTools

              def render_header(layout)
                draw_a5(
                  layout: layout,
                  padding: PADDING_NONE,
                  zone: NO_INDEX,
                  chars: NO_CHARS
                )
              end

              alias render render_header

              def build_legacy_header(layout, fields_with_index, title = nil)
                FIELD_INDEXES.each_with_index do |field_index, index|
                  field = fields_with_index.fetch(index, false)
                  next unless field
                  draw_21(
                    layout: layout,
                    m2: ZERO,
                    m3: field_index,
                    chars: field.to_s
                  )
                end
                return title(gfx: layout, chars: title) if title
                render(layout) unless title
                true
              end

              def build_header(layout, fields_with_index, title = nil)
                FIELD_NEW_INDEXES.each_with_index do |field_index, index|
                  field = fields_with_index.fetch(index, false)
                  next unless field
                  draw_a5(
                    layout: layout,
                    padding: PADDING_NONE,
                    zone: field_index,
                    chars: field.to_s
                  )
                end
                return title(gfx: layout, chars: title.to_s) if title
                render(layout) unless title
                true
              end

              alias build_new_header build_header

              def clear(layout: LAYOUT_HEADER, indices: FIELD_INDEXES)
                indices.each do |index|
                  draw_a5(
                    layout: layout,
                    padding: PADDING_NONE,
                    zone: index,
                    chars: CLEAR_CHARS
                  )
                end
              end

              def generate_header(layout: LAYOUT_HEADER, indices: (0x41..0x47))
                indices.each do |index|
                  draw_a5(
                    layout: layout,
                    padding: PADDING_NONE,
                    zone: index,
                    chars: generate_a5(layout, index)
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
