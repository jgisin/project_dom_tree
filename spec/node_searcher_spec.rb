require 'node_searcher'
require 'dom_parser'

describe "NodeSearcher" do 
  let(:parse){ DOMParser.new("lib/sample2.html") }  
  let(:search){ parse.search }
  before "Pass in the tree to search" do
    parse.create_tree
  end

  describe "#search_by" do

    it "searches for the given class name and value and returns first match" do
      expect(search.search_by("class", "foo").length).to eq(2)
    end

    it "searches for the given class name and value and returns match after first" do
      expect(search.search_by("class", "bar").length).to eq(2)
    end    

    it "returns 0 for invalid search" do
      expect(search.search_by("class", "floo").length).to eq(0)
    end

    it "raises NoMethodError when tree not created" do
      search.tree = nil
      expect{search.search.search_by("class", "foo")}.to raise_error(NoMethodError)
    end


  end

  describe "#search_children" do

    it "searches all children for the query" do
      expect(search.search_children(parse.tree.root, "class", "foo").length).to eq(2)
    end

    it "does not include the parameter node in the search" do
      expect(search.search_children(parse.tree.root.children[0], "class", "foo").length).to eq(1)
    end

    it "raises NoMethodError when parameter is not a node" do
      expect{search.search.search_children("Bla", "class", "foo")}.to raise_error(NoMethodError)
    end

  end

  describe "#search_direct_children" do

    it "searches direct ancestor for the query only" do
      expect(search.search_direct_children(parse.tree.root, "id", "baz").length).to eq(1)
    end

    it "will return empty array if direct ancestor does not contain query" do
      expect(search.search_direct_children(parse.tree.root.children[0], "id", "baz")).to eq([])
    end

    it "raises NoMethodError when parameter is not a node" do
      expect{search.search.search_direct_children("Bla", "class", "foo")}.to raise_error(NoMethodError)
    end

  end
  
end