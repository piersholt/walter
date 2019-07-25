# frozen_string_literal: true

module Wilhelm
  module Services
    class Audio
      class Targets < Collection
        # Audio::Targets::Selection
        module Selection
          # SELECTION -----------------------------------------------------------

          def selected_target
            raise StandardError, 'No selected target!' unless selected_id?
            find_by_id(@selected_id)
          end

          alias selected selected_target

          def select_target(new_target)
            case new_target
            when Wilhelm::Services::Audio::Target
              raise(IndexError, "No matching Target for #{new_target}!") unless find_by_object?(new_target)
              @selected_id = new_target.path
            when String
              raise(IndexError, "No matching ID for #{new_target}!") unless find_by_id?(new_target)
              @selected_id = new_target
            end
          end

          def deselect_target
            @selected_id = nil
          end

          def selected_id
            raise StandardError, 'No selected target!' unless selected_id?
            @selected_id
          end

          def selected_id?
            @selected_id.nil? ? false : @selected_id
          end
        end
      end
    end
  end
end
