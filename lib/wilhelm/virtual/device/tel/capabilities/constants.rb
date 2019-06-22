# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        module Capabilities
          # Radio related command constants
          module Constants
            WAIT_DEFAULT = 0.01

            CONTACTS = [
              'A.Anteater',
              'B.Bonkers',
              'C.Cockatoo',
              'D.Donkey',
              'E.Eagle',
              'F.Fatty',
              'G.Gonzo',
              'H.Henderson',
              'I.India',
              'J.Jamie',
              'K.Karen',
              'L.Lorenzo',
              'M.Mario',
              'N.Nelly',
              'O.Ophelia',
              'P.Porridge'
            ].freeze

            # PONG 0x02
            ANNOUNCE = 0x01

            # TXT-MID 0X21
            CONTACT_DISPLAY_LIMIT = 8
            CONTACT_PAGE_SIZE = 2

            CONTACT_DELIMITER = 6

            DRAW_DIAL = 0x42
            DRAW_DIRECTORY = 0x43
            DRAW_FAVOURITES = 0x80

            MID_DEFAULT = 0x01

            # Contacts Cell Indexing
            # - block must be set or each draw begins at cell 0
            # - delimiter in chars in only requirement for indexing.
            #   the additional bits seen on 4:3 display can be ommitted.
            # - i have attempted various combinations of bits (akin to radio)
            #   but the delimiter is seemingly the only way to index contacts
            # - the delimiters can be used as an offset.
            #   prefixing a contact with 2 delimiters will leave a cell blank
            # - the delimiter offset is relative to the previous contact
            #   not an absolute reference
            # - multiple contacts can be placed in a single message up to a limit
            # - unlike radio, a write (0x21) without block will render cache.
            #   each write will reset the indexing to zero, so all data intended
            #   to be rendered, must be done together.
            # - note, removing the initial flush, and offsetting contacts allows
            #   targetted cell updates.
            # - control character 13 seems to ignore everthing after it until
            #   next valid delimiter?
            PAGE = {
              0 => 0b0100_0000,
              1 => 0b0100_0000,
              2 => 0b0100_0000,
              3 => 0b0000_0000
            }.freeze

            # PAGE = { 0 => 0b0110_0000,
            #          1 => 0b0100_0100,
            #          2 => 0b0101_0000,
            #          3 => 0b0001_0100 }.freeze

            NO_PAGINATION = 0b0010_0000
            CLEAR = [].freeze

            # GFX STATUS 0x22
            STATUS_CLEAR = 0x00
            STATUS_HOME_SUCCESS = 0x02
            STATUS_SUCCESS = 0x03
            STATUS_ERROR = 0xFF

            # TEL-DATA 0x31
            SOURCE_INFO = 0x20
            SOURCE_DIAL = 0x42
            SOURCE_DIR = 0x43
            SOURCE_TOP = 0x80

            ACTION_DIR_OPEN = 0x1F
            ACTION_DIR_BACK = 0x0C
            ACTION_DIR_FORWARD = 0x0D

            ACTION_INFO_OPEN = 0x0A
            ACTION_DIAL_OPEN = 0x1E

            STRENGTH = [0xB2, 0xB3, 0xB4, 0xB5, 0xB6, 0xB7, 0x5F, 0xB8].freeze

            # -----------------------------------------------------------------
            # STATE
            # -----------------------------------------------------------------

            STATE_STATUS = :status
            STATE_LEDS = :leds

            # STATUS ----------------------------------------------------------

            ON = 1
            OFF = 0
            NO = 0
            YES = 1
            DEFAULT_ZERO = NO

            POWER_STATES = [ON, OFF].freeze

            HFS_SHIFT = 0
            MENU_SHIFT = 1
            INCOMING_SHIFT = 2
            DISPLAY_SHIFT = 3
            POWER_SHIFT = 4
            ACTIVE_SHIFT = 5

            # LED -------------------------------------------------------------

            TEL_OFF = 0b0000_0000
            TEL_POWERED = 0b0001_0000

            LED_RED = :red
            LED_YELLOW = :yellow
            LED_GREEN = :green
            LED_COLOURS = [LED_RED, LED_YELLOW, LED_GREEN].freeze

            LED_OFF = :off
            LED_ON = :on
            LED_BLINK = :blink
            LED_STATES = [LED_OFF, LED_ON, LED_BLINK].freeze

            LED_OFF_BITS = 0b00
            LED_ON_BITS = 0b01
            LED_BLINK_BITS = 0b11

            RED_SHIFT = 0
            YELLOW_SHIFT = 2
            GREEN_SHIFT = 4
          end
        end
      end
    end
  end
end
