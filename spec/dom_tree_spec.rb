require 'dom_tree'

describe "DOMTree" do 
  let(:tree){ DOMTree.new }

  describe "#populate_dom" do

    sample1 = [{"tag_type"=>"p", :type=>"open"}, {:content=>"Before text ", :type=>"content"}, {"tag_type"=>"span", :type=>"open"}, {:content=>"mid text (not included in textattribute of the paragraph tag)", :type=>"content"}, {:type=>"close"}, {:content=>" after text.", :type=>"content"}, {:type=>"close"}]

    it "populates the sample dom tree with correct number of nodes" do
      
      expect(tree.populate_dom(sample1)).to eq(sample1.length)
    end

  end
end