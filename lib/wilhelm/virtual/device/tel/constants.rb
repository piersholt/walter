# frozen_string_literal: true

module Wilhelm
  module Virtual
    class Device
      module Telephone
        # Radio related command constants
        module Constants
          # PONG 0x02
          ANNOUNCE = 0x01

          # TXT-MID 0X21
          LAYOUT_DIAL      = 0x42
          LAYOUT_DIRECTORY = 0x43
          LAYOUT_TOP_8     = 0x80

          M2_DEFAULT = 0b0000_0001

          M3_FLUSH     = 0b0010_0000
          M3_BLOCK     = 0b0100_0000
          M3_SOMETHING = 0b0011_0010
          M3_NIL       = 0x00

          CHARS_EMPTY = [].freeze
          STRING_EMPTY = ''

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

          # GFX STATUS 0x22
          STATUS_CLEAR        = 0x00
          STATUS_HOME_SUCCESS = 0x02
          STATUS_SUCCESS      = 0x03
          STATUS_ERROR        = 0xFF

          # TXT-23 0x23
          MFL_CLEAR                = 0x40
          MFL_RADIO_MODE           = 0x41
          MFL_CONTACT              = 0x42 # "TEL1-MessageBank"
          MFL_CONTACT_CALL         = 0x43 # "TEL    98272742"
          DIRECTORY_CONTACT_NAME   = 0x52 # "MUM"
          DIRECTORY_CONTACT_NUMBER = 0x53 # "98272742"
          DIRECTORY_CLEAR          = 0x53
          DIAL_CLEAR               = 0x61
          DIAL_DIGIT               = 0x63 # "35_"
          TOP_8_CLEAR              = 0x80
          TOP_8_NAME               = 0x81 # "MUM"
          TOP_8_NUMBER             = 0x82 # "98272742"
          INFO_HEADER              = 0x90

          IKE_DEFAULT = 0x20

          EMPTY_STRING = ''

          # ANZV-TEL-VAR* 0x24
          STRENGTH          = 0x91 # Array.new(7) { 0xb8 }.join
          CALL_COST_CURRENT = 0x93 # "     0"
          CALL_COST_TOTAL   = 0x94 # "      0"
          CALL_TIME_MINUTES = 0x96 # "  0"
          CALL_TIME_SECONDS = 0x97 # " 0"

          NIL = 0x00

          # TEL-DATA 0x31
          SOURCE_RECENT    = 0x00
          SOURCE_INFO      = 0x20
          SOURCE_DIAL      = 0x42
          SOURCE_DIRECTORY = 0x43
          SOURCE_TOP_8     = 0x80

          FUNCTION_RECENT   = 0x00
          FUNCTION_CONTACT  = 0x01
          FUNCTION_DIAL     = 0x02
          FUNCTION_SOS      = 0x05
          FUNCTION_NAVIGATE = 0x07
          FUNCTION_INFO     = 0x08

          # Function 0x00
          ACTION_RECENT_BACK    = 0x0C
          ACTION_RECENT_FORWARD = 0x0D

          # Function Contact 0x01
          ACTION_SELECT_1 = 0x00
          ACTION_SELECT_2 = 0x02
          ACTION_SELECT_3 = 0x04
          ACTION_SELECT_4 = 0x06
          ACTION_SELECT_5 = 0x10
          ACTION_SELECT_6 = 0x12
          ACTION_SELECT_7 = 0x14
          ACTION_SELECT_8 = 0x16

          # Function Dial 0x02
          ACTION_REMOVE = 0x0a

          # Function SOS 0x05
          ACTION_SOS_OPEN    = 0x0

          # Function Navigate 0x07
          ACTION_SMS_OPEN    = 0x1D
          ACTION_DIAL_OPEN   = 0x1E
          ACTION_DIR_OPEN    = 0x1F

          # Function Navigate Info 0x08
          ACTION_INFO_OPEN   = 0x0A

          FUNCTIONS = {
            FUNCTION_RECENT => {
              ACTION_RECENT_BACK => 'Last Numbers <<',
              ACTION_RECENT_FORWARD => 'Last Numbers >>'
            },
            FUNCTION_CONTACT => {
              ACTION_SELECT_1 => 'Contact 1',
              ACTION_SELECT_2 => 'Contact 2',
              ACTION_SELECT_3 => 'Contact 3',
              ACTION_SELECT_4 => 'Contact 4',
              ACTION_SELECT_5 => 'Contact 5',
              ACTION_SELECT_6 => 'Contact 6',
              ACTION_SELECT_7 => 'Contact 7',
              ACTION_SELECT_8 => 'Contact 8'
            },
            FUNCTION_DIAL => {
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
              ACTION_SOS_OPEN => 'Open Emergency'
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

          # -----------------------------------------------------------------
          # STATE
          # -----------------------------------------------------------------

          STATE_STATUS = :status
          STATE_LEDS = :leds

          # ANZV_BOOL_STATUS ------------------------------------------------

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

          # ANZV_BOOL_LED ---------------------------------------------------

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
