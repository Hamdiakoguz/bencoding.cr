require "./spec_helper"

describe BEncoding do
  it "decodes strings" do
    decoded = BEncoding.decode("7:foo bar")
    decoded.should eq("foo bar")
  end

  it "decodes integers" do
    decoded = BEncoding.decode("i42e")
    decoded.should eq(42)
  end

  it "decodes lists" do
    decoded = BEncoding.decode("li1ei2ei3ee")
    decoded.should eq([1, 2, 3])
  end

  it "decodes dictionaries" do
    decoded = BEncoding.decode("d3:bari-10e3:fooi1ee")
    decoded.should eq({"foo" => 1, "bar" => -10})
  end
end
