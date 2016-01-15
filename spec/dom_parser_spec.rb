require 'dom_parser.rb'

describe DomParser do

  let (:dom_parser) { DomParser.new }
  let (:dom_ui) { DomUI.new }
  let (:html_string) { "<div class='class' id=12345>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"}

  describe '#find_all_tags' do

    it "creates opening Tag Structs" do
      dom_parser.find_all_tags(html_string)
      expect(dom_parser.tag_structs.length).to eq(3)
    end

    it "sets the correct depth for each Struct" do
      dom_parser.find_all_tags(html_string)
      expect(dom_parser.tag_structs[0].depth).to eq(0)
      expect(dom_parser.tag_structs[1].depth).to eq(1)
      expect(dom_parser.tag_structs[2].depth).to eq(1)
    end
  end

  describe '#generate_tree' do

    it 'sets children correctly' do
      dom_parser.find_all_tags(html_string)
      dom_parser.generate_tree
      expect(dom_parser.tag_structs[0].children.length).to eq(1)
      expect(dom_parser.tag_structs[1].children.length).to eq(1)
      expect(dom_parser.tag_structs[2].children.length).to eq(0)
    end
  end

  describe '#set_tag_attributes' do

    it 'creates tag info correctly' do
      new_tag = dom_parser.set_tag_attributes("<div class='class another' id='idea'>", 0)
      expect(new_tag.type).to eq("div")
      expect(new_tag.classes).to eq(["class", "another"])
      expect(new_tag.id).to eq("idea")
    end
  end


  end