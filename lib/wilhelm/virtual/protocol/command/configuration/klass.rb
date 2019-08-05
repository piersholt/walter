# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      class Configuration
        # Virtual::Command::Configuration::Klass
        module Klass
          LOG_METHOD_CONFIGURED = '#configured?'.freeze

          def configure(command_object)
            LOGGER.debug(PROC) { "Configure command #{command_object.class}" }
            command_object.instance_variable_set(
              inst_var(:parameters), parameter_list
            )
          end

          protected

          # initialize =>
          def configure_class
            return false if configured?
            LOGGER.debug(PROC) { "#{sn}: Class Configuration beginning." }
            setup_class_variable
            setup_klass_parameters
            setup_parameter_accessor(:parameters)
            LOGGER.debug(PROC) { "#{sn}: Class Configuration completed." }
            true
          end

          # initialize =>
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

          private

          # configure_class  =>
          def setup_class_variable
            LOGGER.debug(PROC) { "#{sn} #{klass_constant} @@configured = TRUE" }
            klass_constant.class_variable_set(:@@configured, true)
          end

          def setup_klass_parameters
            LOGGER.debug(PROC) { "#{sn} #{klass_constant}: Create parameter accessors: #{parameter_list}..." }
            parameters.each do |name, _|
              setup_parameter_accessor(name)
            end
          end

          def setup_parameter_accessor(parameter)
            LOGGER.debug(PROC) { "#{klass_constant}: Adding #{parameter} accessor" }
            klass_constant.class_eval do
              attr_accessor(parameter)
            end
          end

          # configured? =>
          def configured_defined?
            klass_constant.class_variable_defined?(:@@configured)
          end
        end
      end
    end
  end
end
