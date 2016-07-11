module BEncoding
  alias ObjectType = Hash(String, ObjectType) | Int64 | String | Array(ObjectType)

  def self.decode(str : String)
    Decoder.from(str).decode()
  end

  def self.decode(io : IO)
    Decoder.from(io).decode()
  end

  class Decoder
    getter io : IO
    @current : Char?

    def self.from(io : IO)
      Decoder.new(io)
    end

    def self.from(str : String)
      Decoder.new(MemoryIO.new(str))
    end

    def initialize(@io : IO)
      @current = nil
    end

    def decode
      @current = io.read_char
      raise DecodeError.new("empty io") unless @current
      decode_next_object
    end

    def decode_next_object
      @current = io.read_char unless @current
      case @current
      when DICTIONARY_START
        decode_dictionary
      when LIST_START
        decode_list
      when NUMBER_START
        decode_number
      else
        decode_string
      end
    end

    def decode_dictionary
      @current = io.read_char unless @current
      hash = {} of String => ObjectType

      @current = io.read_char
      while @current != DICTIONARY_END && @current != nil
        key = decode_string
        @current = io.read_char
        val = decode_next_object
        hash[key] = val

        @current = io.read_char
      end

      # puts "decoded hash", hash
      hash
    end

    def decode_list
      @current = io.read_char unless @current
      list = [] of ObjectType
      @current = io.read_char
      while @current != LIST_END && @current != nil
        obj = decode_next_object
        list.push(obj)

        @current = io.read_char
      end

      # puts "decoded list", list
      list
    end

    def decode_number
      @current = io.read_char unless @current
      number = io.gets(NUMBER_END)
      raise DecodeError.new("invalid number") unless number
      num = (number.chomp(NUMBER_END)).to_i64

      # puts "decoded number", num
      num
    end

    def decode_string
      @current = io.read_char unless @current
      to_colon = io.gets(BYTE_ARRAY_DIVIDER)
      raise DecodeError.new("invalid byte array length") unless to_colon
      length = ((@current.not_nil! + to_colon).chomp(BYTE_ARRAY_DIVIDER)).to_u64

      slice = Slice(UInt8).new(length)
      read = io.read(slice)
      while read < length
        slice += read
        read += io.read(slice)
      end

      begin
        String.new(slice, "UTF-8")
      rescue
        slice.hexstring
      end
    end
  end

  class DecodeError < Exception
  end
end
