require "./spec_helper"
require "logger"

describe BEncoding do
  it "decodes strings" do
    decoded = BEncoding.decode("7:foo bar")
    decoded.should eq("foo bar")
  end

  it "decodes integers" do
    decoded = BEncoding.decode("i42e")
    decoded.should eq(42)
  end

  it "decodes arrays" do
    decoded = BEncoding.decode("li1ei2ei3ee")
    decoded.should eq([1, 2, 3])
  end

  it "decodes arrays with integers and string" do
    decoded = BEncoding.decode("li1e3:fooe")
    decoded.should eq([1, "foo"])
  end

  it "decodes hashes" do
    decoded = BEncoding.decode("d3:bari-10e3:fooi1ee")
    decoded.should eq({"foo" => 1, "bar" => -10})
  end

  it "decodes hashes with integer and string values" do
    decoded = BEncoding.decode("d3:bar3:baz3:fooi1ee")
    decoded.should eq({"bar" => "baz", "foo" => 1})
  end

  fixtures_logger = Logger.new(File.new("#{__DIR__}/fixtures.log", "w"))
  Dir["#{__DIR__}/fixtures/*.torrent"].each do |fixture|
    it "decodes #{fixture}" do
      file = File.open(fixture)
      file.sync = true
      decoded = BEncoding.decode(file)
      fixtures_logger.info(decoded)
    end
  end
end
