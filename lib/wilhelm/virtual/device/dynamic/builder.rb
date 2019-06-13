# frozen_string_literal: true

class Wilhelm::Virtual
  # Comment
  class DynamicDeviceBuilder
    include Wilhelm::Helpers::Module

    CLASS_MAP = {
      dsp: 'SimulatedDSP',
      cdc: 'EmulatedCDC',
      tel: 'SimulatedTEL',
      rad: 'SimulatedRadio',
      gfx: 'AugmentedGFX',
      dia: 'ManualDiagnostics',
      iris: 'EmulationDummy',
      nav_jp: 'EmulationDummy',
      bmbt: 'AugmentedBMBT',
      nav: 'EmulationDummy',
      tv: 'EmulationDummy',
      mfl: 'AugmentedMFL'
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
      klass_constant = prepend_namespace('Wilhelm::Virtual', klass_constant)
      klass = get_class(klass_constant)
      klass.new(ident)
    end
  end
end
