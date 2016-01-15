require 'node_renderer.rb'

describe NodeRenderer do

  let(:node_renderer) { NodeRenderer.new }

  describe '#initialize' do

    it 'returns a tree' do
      node_renderer.tree.is_a?(Array)
    end

  end






end