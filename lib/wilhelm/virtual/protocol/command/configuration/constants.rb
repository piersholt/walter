# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      class Configuration
        # Virtual::Command::Configuration::Constants
        module Constants
          include Helpers

          PROC = 'Command::Configuration'.freeze

          MAP       = :map
          SWITCH    = :switch
          BIT_ARRAY = :bit_array
          TYPES     = [MAP, BIT_ARRAY, SWITCH].freeze

          NAMESPACE             = 'Wilhelm::Virtual::Command'.freeze

          BASE                  = 'Base'.freeze
          BASE_BUILDER          = 'Builder'.freeze

          INDEXED_BUILDER       = 'Indexed::Builder'.freeze

          PARAMETERIZED         = 'Parameterized::Base'.freeze
          PARAMETERIZED_BUILDER = 'Parameterized::Builder'.freeze

          LOG_METHOD_INITIALIZE = '#initialize'.freeze

          def logger
            LOGGER
          end

          def base_command
            get_class(join_namespaces(NAMESPACE, BASE))
          end

          def parameterized_command
            get_class(join_namespaces(NAMESPACE, PARAMETERIZED))
          end

          def base_builder
            get_class(join_namespaces(NAMESPACE, BASE_BUILDER))
          end

          def indexed_builder
            get_class(join_namespaces(NAMESPACE, INDEXED_BUILDER))
          end

          alias default_builder base_builder

          def parameterized_builder
            get_class(join_namespaces(NAMESPACE, PARAMETERIZED_BUILDER))
          end
        end
      end
    end
  end
end
