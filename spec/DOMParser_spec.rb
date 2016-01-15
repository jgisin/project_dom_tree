require 'dom_parser'

describe "DOMParser" do
  let(:dom){ DOMParser.new } 
  let(:p_test){"<p class='foo bar' id='baz' name='fozzie'>"}
  let(:url_test){"<img src='http://www.example.com' title='funny things'>"}
  let(:p_hash){{"tag_type"=>"p", "class"=>["foo", "bar"], "id"=>["baz"], "name"=>["fozzie"]}}
  let(:url_hash){{"tag_type"=>"img", "src"=>["http://www.example.com"], "title"=>["funny", "things"]}}  

  describe "#tag_parser" do


    it "parses tags into a hash, with attr_name (key) attr_value (value" do
      expect(dom.tag_parser(p_test)).to eq(p_hash)
    end

    it "parses tags with urls" do
      expect(dom.tag_parser(url_test)).to eq(url_hash)
    end

  end

  describe "#tag_printer" do

    it "returns hash into html (paragraph test)" do
      expect(dom.tag_printer(p_hash)).to eq(p_test)
    end

    it "returns html with urls from hash" do
      expect(dom.tag_printer(url_hash)).to eq(url_test)
    end

  end
end