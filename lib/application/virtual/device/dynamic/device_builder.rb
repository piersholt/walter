# frozen_string_literal: true

class Virtual
  # Comment
  class DynamicDeviceBuilder
    include ModuleTools

    CLASS_MAP = {
      dsp: 'SimulatedDSP',
      cdc: 'SimulatedCDC',
      tel: 'SimulatedTEL',
      rad: 'AugmentedRadio',
      dia: 'ManualDiagnostics'
    }.freeze

    attr_reader :ident

    def name
      'DynamicDeviceBuilder'
    end

    def target(ident)
      LOGGER.debug(name) { ident }
      raise StandardError, "no class to target #{ident}" unless CLASS_MAP.key?(ident)
      @ident = ident
      self
    end

    def result
      raise StandardError, "no ident set!" unless @ident
      klass_constant = CLASS_MAP[ident]
      klass_constant = prepend_namespace('Virtual', klass_constant)
      klass = get_class(klass_constant)
      klass.new(ident)
    end
  end
end
