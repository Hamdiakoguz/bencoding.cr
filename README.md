# bencoding.cr

Crystal library for the bencode data serialization format

## What is bencode?

Bencode is a simple data serialization format used by the popular
[BitTorrent](http://bittorrent.org/) P2P file sharing system.

It contains only four data types, namely:

- strings
- integers
- arrays
- hashes

For more info see [spec](http://www.bittorrent.org/beps/bep_0003.html#bencoding).

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  bencoding.cr:
    github: Hamdiakoguz/bencoding.cr
```

## Usage

```crystal
require "bencoding.cr"

# Decoding:
BEncoding.decode("d3:foo3:bar3:bazi42ee") # => {"foo" => "bar", "baz" => 42}

# Encoding:

BEncoding.encode("foo bar") # => "7:foo bar"
BEncoding.encode(42) # => "i42e"
BEncoding.encode([1, 2, 3]) # => "li1ei2ei3ee"
BEncoding.encode({"foo" => 1, "bar" => -10}) # => "d3:bari-10e3:fooi1ee"
```


## Contributing

1. Fork it ( https://github.com/Hamdiakoguz/bencoding.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Hamdiakoguz](https://github.com/Hamdiakoguz) Hamdi Akoğuz - creator, maintainer
