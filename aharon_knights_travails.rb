require_relative "./aharon_PolyTreeNode.rb"

class KnightPathFinder
    def initialize(start_pos)
        @start_pos = start_pos
        @root_node = PolyTreeNode.new(start_pos)
    end
end