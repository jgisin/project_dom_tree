require 'html_reader'

describe "HTMLReader" do
  let(:reader) {HTMLReader.new}
  let(:opening) {"<div>"}
  let(:closing) {"</div>"}
  let(:ig_opening) {"<em>"}
  let(:ig_closing) {"</em>"}

  describe "initialize" do

  end

  describe "is_tag?" do
    it "returns true if it is an (opening tag)" do
      expect(reader.is_tag?(opening)).to eq(true)
    end

    it "returns false if it is not an opening tag" do
      expect(reader.is_tag?(closing)).to eq(false)
    end

    it "returns false if not a tag at all" do
      expect(reader.is_tag?("text")).to eq(false)
    end
  end

  describe "is_closing_tag" do
    it "false if not a closing tag" do
      expect(reader.is_closing_tag?(opening)).to eq(false)
    end

    it "true if is a closing tag" do
      expect(reader.is_closing_tag?(closing)).to eq(true)
    end

    it "returns false if not a tag at all" do
      expect(reader.is_closing_tag?("text")).to eq(false)
    end
  end

  describe "is_ignore_tag?" do
    it "returns true if it is an ignore (opening tag)" do
      expect(reader.is_ignore_tag?(ig_opening)).to eq(true)
    end

    it "returns false if it is not an ignore opening tag" do
      expect(reader.is_ignore_tag?(ig_closing)).to eq(false)
    end

    it "returns false if not a ignore tag at all" do
      expect(reader.is_ignore_tag?("text")).to eq(false)
    end
  end

  describe "is_ignore_closing_tag" do
    it "false if not a closing tag" do
      expect(reader.is_ignore_closing_tag?(ig_opening)).to eq(false)
    end

    it "true if is a closing tag" do
      expect(reader.is_ignore_closing_tag?(ig_closing)).to eq(true)
    end

    it "returns false if not a tag at all" do
      expect(reader.is_ignore_closing_tag?("text")).to eq(false)
    end
  end

end
