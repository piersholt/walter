# frame_helper.rb
require 'byte'

# *************************************************************************** #

# BYTE HELPER
BYTE_ASCII_8BIT_0x80 = '80'.hex.chr
BYTE_ASCII_8BIT_0xF0 = 'F0'.hex.chr

BYTE_ENCODED_0x80 = BYTE_ASCII_8BIT_0x80
BYTE_ENCODED_0xF0 = BYTE_ASCII_8BIT_0xF0

# VALUE VALIDATION
BYTE_ASCII_8BIT_VALID = BYTE_ASCII_8BIT_0xF0

# ALIASES
BYTE_ENCODED_VALID = BYTE_ENCODED_0x80


# *************************************************************************** #

# FRAME HELPER

FRAME_ENCODED = ['68', '04', 'FF', '02', '00', '91'].map do |h|
  data_encoded = DataTools.public_send(:hex_to_encoded, h)
  Byte.new(:encoded, data_encoded)
end

FRAME_HEADER = FRAME_ENCODED[0..1]
FRAME_TAIL = FRAME_ENCODED[2..-1]

# *************************************************************************** #
