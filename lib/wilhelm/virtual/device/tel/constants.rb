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
          LAYOUT_DEFAULT   = 0x00
          LAYOUT_PIN       = 0x05
          LAYOUT_INFO      = 0x20
          LAYOUT_DIAL      = 0x42
          LAYOUT_DIRECTORY = 0x43
          LAYOUT_TOP_8     = 0x80
          LAYOUT_SMS_INDEX = 0xf0
          LAYOUT_SMS_SHOW  = 0xf1

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
          DEFAULT_TITLE            = 0x00
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
          # LAYOUT_DEFAULT      = 0x00
          # LAYOUT_PIN       = 0x05
          # LAYOUT_INFO      = 0x20
          # LAYOUT_DIAL      = 0x42
          # LAYOUT_DIRECTORY = 0x43
          # LAYOUT_TOP_8     = 0x80

          # BYTE 2 FUNCTION
          FUNCTION_DEFAULT  = 0x00
          FUNCTION_CONTACT  = 0x01
          FUNCTION_DIGIT    = 0x02
          FUNCTION_SOS      = 0x05
          FUNCTION_NAVIGATE = 0x07
          FUNCTION_INFO     = 0x08

          # BYTE 3 ACTION

          # Function 0x00

          # Layout 0x00 Last Numbers, 0x43 Directory
          ACTION_RECENT_BACK    = 0x0c
          ACTION_RECENT_FORWARD = 0x0d

          RECENT_BACK    = 'Last Numbers <<'
          RECENT_FORWARD = 'Last Numbers >>'

          # Layout 0xf0 SMS Index
          ACTION_SMS_1  = 0x00
          ACTION_SMS_2  = 0x01
          ACTION_SMS_3  = 0x02
          ACTION_SMS_4  = 0x03
          ACTION_SMS_5  = 0x04
          ACTION_SMS_6  = 0x05
          ACTION_SMS_7  = 0x06
          ACTION_SMS_8  = 0x07
          ACTION_SMS_9  = 0x08
          ACTION_SMS_10 = 0x09
          ACTION_SMS_11 = 0x13

          SMS_1  = 'Message 1'
          SMS_2  = 'Message 2'
          SMS_3  = 'Message 3'
          SMS_4  = 'Message 4'
          SMS_5  = 'Message 5'
          SMS_6  = 'Message 6'
          SMS_7  = 'Message 7'
          SMS_8  = 'Message 8'
          SMS_9  = 'Message 9'
          SMS_10 = 'Message 10'
          SMS_11 = 'Back'

          # Layout 0xf1 SMS Message
          ACTION_SMS_BACK   = 0x10
          ACTION_SMS_LEFT   = 0x11
          ACTION_SMS_RIGHT  = 0x12
          ACTION_SMS_CENTRE = 0x13

          SMS_BACK   = 'Back'
          SMS_LEFT   = 'Button Left'
          SMS_CENTRE = 'Button Centre'
          SMS_RIGHT  = 'Button Right'

          # Function Contact 0x01
          ACTION_CONTACT_1 = 0x00
          ACTION_CONTACT_2 = 0x02
          ACTION_CONTACT_3 = 0x04
          ACTION_CONTACT_4 = 0x06
          ACTION_CONTACT_5 = 0x10
          ACTION_CONTACT_6 = 0x12
          ACTION_CONTACT_7 = 0x14
          ACTION_CONTACT_8 = 0x16

          DIRECTORY_CONTACT_1 = 'Dir: Contact 1'
          DIRECTORY_CONTACT_2 = 'Dir: Contact 2'
          DIRECTORY_CONTACT_3 = 'Dir: Contact 3'
          DIRECTORY_CONTACT_4 = 'Dir: Contact 4'
          DIRECTORY_CONTACT_5 = 'Dir: Contact 5'
          DIRECTORY_CONTACT_6 = 'Dir: Contact 6'
          DIRECTORY_CONTACT_7 = 'Dir: Contact 7'
          DIRECTORY_CONTACT_8 = 'Dir: Contact 8'

          TOP_8_CONTACT_1 = 'Top 8: Contact 1'
          TOP_8_CONTACT_2 = 'Top 8: Contact 2'
          TOP_8_CONTACT_3 = 'Top 8: Contact 3'
          TOP_8_CONTACT_4 = 'Top 8: Contact 4'
          TOP_8_CONTACT_5 = 'Top 8: Contact 5'
          TOP_8_CONTACT_6 = 'Top 8: Contact 6'
          TOP_8_CONTACT_7 = 'Top 8: Contact 7'
          TOP_8_CONTACT_8 = 'Top 8: Contact 8'

          # Function Dial 0x02
          ACTION_DIAL_0      = 0x00
          ACTION_DIAL_1      = 0x01
          ACTION_DIAL_2      = 0x02
          ACTION_DIAL_3      = 0x03
          ACTION_DIAL_4      = 0x04
          ACTION_DIAL_5      = 0x05
          ACTION_DIAL_6      = 0x06
          ACTION_DIAL_7      = 0x07
          ACTION_DIAL_8      = 0x08
          ACTION_DIAL_9      = 0x09
          ACTION_DIAL_DELETE = 0x0a
          ACTION_DIAL_STAR   = 0x1a
          ACTION_DIAL_HASH   = 0x1b

          ACTION_PIN_0      = 0x00
          ACTION_PIN_1      = 0x01
          ACTION_PIN_2      = 0x02
          ACTION_PIN_3      = 0x03
          ACTION_PIN_4      = 0x04
          ACTION_PIN_5      = 0x05
          ACTION_PIN_6      = 0x06
          ACTION_PIN_7      = 0x07
          ACTION_PIN_8      = 0x08
          ACTION_PIN_9      = 0x09
          ACTION_PIN_DELETE = 0x0a
          ACTION_PIN_OK     = 0x1b

          DIGIT_0 = '0'
          DIGIT_1 = '1'
          DIGIT_2 = '2'
          DIGIT_3 = '3'
          DIGIT_4 = '4'
          DIGIT_5 = '5'
          DIGIT_6 = '6'
          DIGIT_7 = '7'
          DIGIT_8 = '8'
          DIGIT_9 = '9'
          DIGIT_STAR = '*'
          DIGIT_HASH = '#'
          DIGIT_DELETE = '<'
          DIGIT_OK = 'OK'

          # Function SOS 0x05
          ACTION_SOS_OPEN = 0x08

          OPEN_SOS = 'Open SOS'
          DEFAULT_OPEN_SOS = '* -> Open SOS'
          PIN_OPEN_SOS = 'PIN -> Open SOS'
          DIAL_OPEN_SOS = 'Dial -> Open SOS'

          # Function Navigate 0x07
          ACTION_SMS_OPEN    = 0x1d
          ACTION_DIAL_OPEN   = 0x1e
          ACTION_DIR_OPEN    = 0x1f

          OPEN_SMS       = 'Open SMS'
          OPEN_DIAL      = 'Open Dial'
          OPEN_DIRECTORY = 'Open Directory'

          DIAL_OPEN_SMS       = 'Dial -> Open SMS'
          DIAL_OPEN_DIAL      = 'Dial -> Open Dial'
          DIAL_OPEN_DIRECTORY = 'Dial -> Open Directory'

          DIRECTORY_OPEN_DIAL = 'Directory -> Open Dial'

          TOP_8_OPEN_DIAL = 'Top 8 -> Open Dial'

          INFO_OPEN_DIAL = 'Info -> Open Dial'

          # Function Navigate Info 0x08
          ACTION_INFO_OPEN = 0x0a

          DIAL_OPEN_INFO = 'Dial -> Open Info'

          INPUT_MAP = {
            LAYOUT_DEFAULT => {
              FUNCTION_DEFAULT => {
                ACTION_RECENT_BACK    => RECENT_BACK,
                ACTION_RECENT_FORWARD => RECENT_FORWARD
              },
              FUNCTION_SOS => {
                ACTION_SOS_OPEN => DEFAULT_OPEN_SOS
              }
            },
            LAYOUT_PIN => {
              FUNCTION_DIGIT => {
                ACTION_PIN_0      => DIGIT_0,
                ACTION_PIN_1      => DIGIT_1,
                ACTION_PIN_2      => DIGIT_2,
                ACTION_PIN_3      => DIGIT_3,
                ACTION_PIN_4      => DIGIT_4,
                ACTION_PIN_5      => DIGIT_5,
                ACTION_PIN_6      => DIGIT_6,
                ACTION_PIN_7      => DIGIT_7,
                ACTION_PIN_8      => DIGIT_8,
                ACTION_PIN_9      => DIGIT_9,
                ACTION_PIN_DELETE => DIGIT_DELETE,
                ACTION_PIN_OK     => DIGIT_OK
              },
              FUNCTION_SOS => {
                ACTION_SOS_OPEN => PIN_OPEN_SOS
              }
            },
            LAYOUT_DIAL => {
              FUNCTION_DIGIT => {
                ACTION_DIAL_0      => DIGIT_0,
                ACTION_DIAL_1      => DIGIT_1,
                ACTION_DIAL_2      => DIGIT_2,
                ACTION_DIAL_3      => DIGIT_3,
                ACTION_DIAL_4      => DIGIT_4,
                ACTION_DIAL_5      => DIGIT_5,
                ACTION_DIAL_6      => DIGIT_6,
                ACTION_DIAL_7      => DIGIT_7,
                ACTION_DIAL_8      => DIGIT_8,
                ACTION_DIAL_9      => DIGIT_9,
                ACTION_DIAL_STAR   => DIGIT_STAR,
                ACTION_DIAL_HASH   => DIGIT_HASH,
                ACTION_DIAL_DELETE => DIGIT_DELETE
              },
              FUNCTION_SOS => {
                ACTION_SOS_OPEN => DIAL_OPEN_SOS
              },
              FUNCTION_NAVIGATE => {
                ACTION_DIR_OPEN => DIAL_OPEN_DIRECTORY,
                ACTION_SMS_OPEN => DIAL_OPEN_SMS
              },
              FUNCTION_INFO => {
                ACTION_INFO_OPEN => DIAL_OPEN_INFO
              }
            },
            LAYOUT_DIRECTORY => {
              FUNCTION_CONTACT => {
                ACTION_CONTACT_1 => DIRECTORY_CONTACT_1,
                ACTION_CONTACT_2 => DIRECTORY_CONTACT_2,
                ACTION_CONTACT_3 => DIRECTORY_CONTACT_3,
                ACTION_CONTACT_4 => DIRECTORY_CONTACT_4,
                ACTION_CONTACT_5 => DIRECTORY_CONTACT_5,
                ACTION_CONTACT_6 => DIRECTORY_CONTACT_6,
                ACTION_CONTACT_7 => DIRECTORY_CONTACT_7,
                ACTION_CONTACT_8 => DIRECTORY_CONTACT_8
              },
              FUNCTION_NAVIGATE => {
                ACTION_DIAL_OPEN => DIRECTORY_OPEN_DIAL
              }
            },
            LAYOUT_TOP_8 => {
              FUNCTION_CONTACT => {
                ACTION_CONTACT_1 => TOP_8_CONTACT_1,
                ACTION_CONTACT_2 => TOP_8_CONTACT_2,
                ACTION_CONTACT_3 => TOP_8_CONTACT_3,
                ACTION_CONTACT_4 => TOP_8_CONTACT_4,
                ACTION_CONTACT_5 => TOP_8_CONTACT_5,
                ACTION_CONTACT_6 => TOP_8_CONTACT_6,
                ACTION_CONTACT_7 => TOP_8_CONTACT_7,
                ACTION_CONTACT_8 => TOP_8_CONTACT_8
              },
              FUNCTION_NAVIGATE => {
                ACTION_DIAL_OPEN => TOP_8_OPEN_DIAL
              }
            },
            LAYOUT_INFO => {
              FUNCTION_NAVIGATE => {
                ACTION_DIAL_OPEN => INFO_OPEN_DIAL
              }
            },
            LAYOUT_SMS_INDEX => {
              FUNCTION_DEFAULT => {
                ACTION_SMS_1  => SMS_1,
                ACTION_SMS_2  => SMS_2,
                ACTION_SMS_3  => SMS_3,
                ACTION_SMS_4  => SMS_4,
                ACTION_SMS_5  => SMS_5,
                ACTION_SMS_6  => SMS_6,
                ACTION_SMS_7  => SMS_7,
                ACTION_SMS_8  => SMS_8,
                ACTION_SMS_9  => SMS_9,
                ACTION_SMS_10 => SMS_10,
                ACTION_SMS_11 => SMS_11
              }
            },
            LAYOUT_SMS_SHOW => {
              FUNCTION_DEFAULT => {
                ACTION_SMS_BACK   => SMS_BACK,
                ACTION_SMS_LEFT   => SMS_LEFT,
                ACTION_SMS_CENTRE => SMS_CENTRE,
                ACTION_SMS_RIGHT  => SMS_RIGHT
              }
            }
          }.freeze

          def map(layout, function, action)
            layout = INPUT_MAP.fetch(layout.value, raise(StandardError, 'no layout!'))
            function = layout.fetch(function.value, raise(StandardError, 'no function!'))
            function.fetch(action.value, raise(StandardError, 'no action!!'))
          end

          INPUT_PRESS = 0b00
        end
      end
    end
  end
end
