module BEncoding
  def self.encode(param)
    io = MemoryIO.new
    Encoder.new(io).encode(param)
    io.to_s
  end

  class Encoder
    def initialize(@io : IO)
    end

    def encode(param : Int)
      @io << NUMBER_START
      @io << param.to_s
      @io << NUMBER_END
    end

    def encode(param : String)
      @io << param.size
      @io << BYTE_ARRAY_DIVIDER
      @io << param
    end

    def encode(param : Hash(String, T))
      @io << DICTIONARY_START
      param.keys.sort.each do |key|
        encode(key)
        encode(param[key])
      end
      @io << DICTIONARY_END
    end

    def encode(param : Enumerable)
      @io << LIST_START
      param.each {|p| encode(p) }
      @io << LIST_END
    end
  end
end
