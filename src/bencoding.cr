require "./bencoding/**"

module BEncoding
  DICTIONARY_START   = 'd' # 100
  DICTIONARY_END     = 'e' # 101
  LIST_START         = 'l' # 108
  LIST_END           = 'e' # 101
  NUMBER_START       = 'i' # 105
  NUMBER_END         = 'e' # 101
  BYTE_ARRAY_DIVIDER = ':' #  58
end
