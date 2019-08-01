# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        # Radio related command constants
        module Constants
          # -------------------------------------------------------------------
          # PONG 0x02
          # -------------------------------------------------------------------
          ANNOUNCE = 0x01

          # -------------------------------------------------------------------
          # TXT-MID 0X21
          # -------------------------------------------------------------------

          # Parameter :layout
          LAYOUT_NONE      = 0x00
          LAYOUT_PIN       = 0x05
          LAYOUT_INFO      = 0x20
          LAYOUT_DIAL      = 0x42
          LAYOUT_DIRECTORY = 0x43
          LAYOUT_TOP_8     = 0x80

          # Parameter :m2
          M2_DEFAULT = 0b0000_0001

          # Parameter :m3
          M3_FLUSH     = 0b0010_0000
          M3_BLOCK     = 0b0100_0000
          M3_SOMETHING = 0b0011_0010
          M3_NIL       = 0x00

          # Parameter :chars
          CHARS_EMPTY = [].freeze
          STRING_BLANK = ''

          # Contacts Cell Indexing
          # - block must be set or each draw begins at cell 0
          # - delimiter in chars in only requirement for indexing.
          #   the additional bits seen on 4:3 display can be ommitted-
          #   they might be for MID?
          # - i have attempted various combinations of bits (akin to radio)
          #   but the delimiter is seemingly the only way to index contacts
          # - the delimiters can be used as an offset.
          #   prefixing a contact with 2 delimiters will leave a cell blank
          # - the delimiter offset is relative to the previous contact
          #   not an absolute reference
          # - a single message can have multiple delimitered contacts,
          #   but this is up to a limit
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

          # -------------------------------------------------------------------
          # GFX STATUS 0x22
          # -------------------------------------------------------------------

          STATUS_CLEAR        = 0x00
          STATUS_HOME_SUCCESS = 0x02
          STATUS_SUCCESS      = 0x03
          STATUS_ERROR        = 0xff

          # -------------------------------------------------------------------
          # TXT-23 0x23
          # -------------------------------------------------------------------

          # Parameter :gfx
          # IKE via MFL
          MFL_CLEAR                = 0x40
          MFL_RADIO_MODE           = 0x41
          MFL_CONTACT              = 0x42 # "TEL1-MessageBank"
          MFL_CONTACT_CALL         = 0x43 # "TEL    98272742"

          # GFX via BMBT
          SOS_TITLE                = 0x00
          PIN_TITLE                = 0x05
          DIRECTORY_CONTACT_NAME   = 0x52 # "MUM"
          DIRECTORY_CONTACT_NUMBER = 0x53 # "98272742"
          DIRECTORY_CLEAR          = 0x53 # ''
          DIAL_CLEAR               = 0x61 # ''
          DIAL_DIGIT               = 0x63 # "35_"
          TOP_8_CLEAR              = 0x80 # ''
          TOP_8_NAME               = 0x81 # "MUM"
          TOP_8_NUMBER             = 0x82 # "98272742"
          INFO_HEADER              = 0x90

          # Parameter :ike
          IKE_DEFAULT = 0x20

          # Parameter :chars
          # @note defined in 0x21
          # STRING_BLANK = ''

          # -------------------------------------------------------------------
          # ANZV-TEL-VAR* 0x24
          # -------------------------------------------------------------------

          # Parameter :gfx
          STRENGTH          = 0x91 # Array.new(7) { 0xb8 }.join
          CALL_COST_CURRENT = 0x93 # "     0"
          CALL_COST_TOTAL   = 0x94 # "      0"
          CALL_TIME_MINUTES = 0x96 # "  0"
          CALL_TIME_SECONDS = 0x97 # " 0"

          # Parameter :ike
          IKE_ZERO = 0x00

          # -------------------------------------------------------------------
          # TEL-DATA 0x31
          # -------------------------------------------------------------------

          # BYTE 1 SOURCE
          # @note defined in 0x21
          # LAYOUT_NONE      = 0x00
          # LAYOUT_PIN       = 0x05
          # LAYOUT_INFO      = 0x20
          # LAYOUT_DIAL      = 0x42
          # LAYOUT_DIRECTORY = 0x43
          # LAYOUT_TOP_8     = 0x80

          # BYTE 2 FUNCTION
          FUNCTION_RECENT   = 0x00
          FUNCTION_CONTACT  = 0x01
          FUNCTION_DIGIT    = 0x02
          FUNCTION_SOS      = 0x05
          FUNCTION_NAVIGATE = 0x07
          FUNCTION_INFO     = 0x08

          # BYTE 3 ACTION
          # Function 0x00
          ACTION_RECENT_BACK    = 0x0c
          ACTION_RECENT_FORWARD = 0x0d

          # Function Contact 0x01
          ACTION_CONTACT_1 = 0x00
          ACTION_CONTACT_2 = 0x02
          ACTION_CONTACT_3 = 0x04
          ACTION_CONTACT_4 = 0x06
          ACTION_CONTACT_5 = 0x10
          ACTION_CONTACT_6 = 0x12
          ACTION_CONTACT_7 = 0x14
          ACTION_CONTACT_8 = 0x16

          # Function Dial 0x02
          ACTION_REMOVE = 0x0a

          # Function SOS 0x05
          ACTION_SOS_OPEN    = 0x08

          # Function Navigate 0x07
          ACTION_SMS_OPEN    = 0x1d
          ACTION_DIAL_OPEN   = 0x1e
          ACTION_DIR_OPEN    = 0x1f

          # Function Navigate Info 0x08
          ACTION_INFO_OPEN   = 0x0a

          FUNCTIONS = {
            FUNCTION_RECENT => {
              ACTION_RECENT_BACK => 'Last Numbers <<',
              ACTION_RECENT_FORWARD => 'Last Numbers >>'
            },
            FUNCTION_CONTACT => {
              ACTION_CONTACT_1 => 'Contact 1',
              ACTION_CONTACT_2 => 'Contact 2',
              ACTION_CONTACT_3 => 'Contact 3',
              ACTION_CONTACT_4 => 'Contact 4',
              ACTION_CONTACT_5 => 'Contact 5',
              ACTION_CONTACT_6 => 'Contact 6',
              ACTION_CONTACT_7 => 'Contact 7',
              ACTION_CONTACT_8 => 'Contact 8'
            },
            FUNCTION_DIGIT => {
              0x00 => '0',
              0x01 => '1',
              0x02 => '2',
              0x03 => '3',
              0x04 => '4',
              0x05 => '5',
              0x06 => '6',
              0x07 => '7',
              0x08 => '8',
              0x09 => '9',
              ACTION_REMOVE => '<',
              0x1a => '*',
              0x1b => '#'
            },
            FUNCTION_SOS => {
              ACTION_SOS_OPEN => 'Open SOS'
            },
            FUNCTION_NAVIGATE => {
              ACTION_DIAL_OPEN => 'Open Dial',
              ACTION_SMS_OPEN => 'Open SMS',
              ACTION_DIR_OPEN => 'Open Directory'
            },
            FUNCTION_INFO => {
              ACTION_INFO_OPEN => 'Open Info'
            }
          }.freeze

          INPUT_PRESS = 0b00
        end
      end
    end
  end
end
