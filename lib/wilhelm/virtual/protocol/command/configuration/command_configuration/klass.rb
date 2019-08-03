# frozen_string_literal: false

module Wilhelm
  module Virtual
    class CommandConfiguration
      # CommandConfiguration::Klass
      module Klass
        LOG_METHOD_CONFIGURED = '#configured?'.freeze

        def configured?
          LOGGER.debug(PROC) { LOG_METHOD_CONFIGURED }
          if !parameters?
            LOGGER.debug(PROC) do
              "#{sn} has no parameters! Configuration not required."
            end
            true
          elsif base?
            LOGGER.debug(PROC) do
              "#{sn} is BaseCommand. Configuration not required."
            end
            true
          elsif parameterized?
            LOGGER.debug(PROC) do
              "#{sn} is, or ancesor of #{PARAMETERIZED}." \
              'Configuration always required.'
            end
            false
          elsif configured_defined?
            LOGGER.debug(PROC) do
              "#{sn} @@configured defined. Configuration already completed."
            end
            true
          else
            LOGGER.debug(PROC) do
              "#{sn} Defaulting to false. Configuration required."
            end
            false
          end
        end

        def configure_class
          LOGGER.debug(PROC) { "#{sn}: Class Configuration beginning." }
          setup_class_variable
          setup_klass_parameters
          setup_parameter_accessor(:parameters)
          LOGGER.debug(PROC) { "#{sn}: Class Configuration completed." }
          true
        end

        private

        def configured_defined?
          klass_constant.class_variable_defined?(:@@configured)
        end

        def setup_class_variable
          klass_constant.class_variable_set(:@@configured, true)
        end

        def setup_klass_parameters
          parameters.each do |name, _|
            setup_parameter_accessor(name)
          end
        end

        def setup_parameter_accessor(parameter)
          LOGGER.debug(PROC) { "Adding #{parameter} accessor" }
          klass_constant.class_eval do
            attr_accessor(parameter)
          end
        end
      end
    end
  end
end
