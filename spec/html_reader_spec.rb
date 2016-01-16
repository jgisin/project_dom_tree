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

  describe "#convert_file" do

    it "converts text to array after processing" do
      reader.file = "lib/sample.html"
      expect(reader.convert_file).to be_a(Array)
    end

    it "processes html into distinct elements" do
      reader.file = "lib/sample.html"
      expect(reader.convert_file).to eq(["<div>",
                                         "div text before",
                                         "<p>",
                                         "p text",
                                         "</p>",
                                         "<div>",
                                         "more div text",
                                         "</div>",
                                         "div text after",
                                         "</div>"])
    end

  end


end
