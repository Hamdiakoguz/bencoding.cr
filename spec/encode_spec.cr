require "./spec_helper"

describe BEncoding do
  it "encodes strings" do
    encoded = BEncoding.encode("foo bar")
    encoded.should eq("7:foo bar")
  end

  it "encodes integers" do
    encoded = BEncoding.encode(42)
    encoded.should eq("i42e")
  end

  it "encodes arrays with numbers" do
    encoded = BEncoding.encode([1, 2, 3])
    encoded.should eq("li1ei2ei3ee")
  end

  it "encodes arrays with integers and strings" do
    encoded = BEncoding.encode([1, "foo"])
    encoded.should eq("li1e3:fooe")
  end

  it "encodes hashes" do
    encoded = BEncoding.encode({"foo" => 1, "bar" => -10})
    encoded.should eq("d3:bari-10e3:fooi1ee")
  end

  it "encodes hashes with integer and string values" do
    encoded = BEncoding.encode({"foo" => 1, "bar" => "baz"})
    encoded.should eq("d3:bar3:baz3:fooi1ee")
  end
end
