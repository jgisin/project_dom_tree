require 'node_renderer'
require 'dom_parser'

describe "NodeRenderer" do

  let(:render){ NodeRenderer.new }
  let(:parse){ DOMParser.new("lib/sample2.html") }

  describe "#render_chid_count" do

    before "Populate tree" do
      parse.create_tree
    end
    
    it "returns the number of child nodes from the specified node" do
      expect(parse.render.render_child_count).to eq(23)
    end

    it "raises NoMethedError if param is not a node" do
      expect{parse.render.render_child_count(1)}.to raise_error(NoMethodError)
    end
  end
end