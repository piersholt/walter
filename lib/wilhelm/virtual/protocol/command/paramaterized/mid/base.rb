# frozen_string_literal: false

module Wilhelm
  module Virtual
    class Command
      module Parameterized
        module MID
          # Command::Parameterized::MID::Telephone
          class Base < Parameterized::Base
            class_variable_set(:@@configured, true)
            attr_accessor(:layout, :m2, :m3)
          end
        end
      end
    end
  end
end
