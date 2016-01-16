require 'dom_parser'

describe "DOMParser" do
  let(:dom){ DOMParser.new("lib/sample2.html") } 
  let(:p_test){"<p class='foo bar' id='baz' name='fozzie'>"}
  let(:url_test){"<img src='http://www.example.com' title='funny things'>"}
  let(:p_hash){{:tag_type=>"p", "class"=>["foo", "bar"], "id"=>["baz"], "name"=>["fozzie"]}}
  let(:url_hash){{:tag_type=>"img", "src"=>["http://www.example.com"], "title"=>["funny", "things"]}}  

  describe "#tag_parser" do


    it "parses tags into a hash, with attr_name (key) attr_value (value" do
      expect(dom.tag_parser(p_test)).to eq(p_hash)
    end

    it "parses simple tags" do
      expect(dom.tag_parser("<div>")).to eq({:tag_type => "div"})
    end

    it "parses tags with urls" do
      expect(dom.tag_parser(url_test)).to eq(url_hash)
    end

    it "raises NoMethodError when passed anything but a string" do
      expect{dom.tag_parser(3)}.to raise_error(NoMethodError)
    end

  end

  describe "#tag_printer" do

    it "returns hash into html (paragraph test)" do
      expect(dom.tag_printer(p_hash)).to eq(p_test)
    end

    it "returns html with urls from hash" do
      expect(dom.tag_printer(url_hash)).to eq(url_test)
    end

    it "raises TypeError when passed anything but a string" do
      expect{dom.tag_printer(3)}.to raise_error(TypeError)
    end

  end

  describe "#content_parser" do

    it "turns content into a :content => data hash" do
      expect(dom.content_parser("content")).to eq({:content => "content"})
    end

    it "raises TypeError when passed anything but a string" do
      expect{dom.content_parser(3)}.to raise_error(TypeError)
    end
  end
end