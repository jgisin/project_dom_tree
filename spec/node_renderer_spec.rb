require 'node_renderer.rb'

describe NodeRenderer do

  let(:nr) { NodeRenderer.new }

  describe '#find_our_node' do

    it 'returns tag that matches target_node' do
      nr.find_our_node("html")
    end

  end






end