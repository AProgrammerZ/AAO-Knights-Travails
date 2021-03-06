require "byebug"
require_relative "./aharon_PolyTreeNode.rb"

class KnightPathFinder        
    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
        self.build_move_tree
    end

    def self.valid_moves(pos)
        my_row = pos[0]
        my_col = pos[1]

        possible_coordinates = 
        [ 
            [my_row+2, my_col+1],
            [my_row+1, my_col+2],
            [my_row-1, my_col+2],
            [my_row-2, my_col+1],
            [my_row-2, my_col-1],
            [my_row-1, my_col-2],
            [my_row+1, my_col-2],
            [my_row+2, my_col-1]
        ]
        possible_coordinates.reject! do |coord| 
            # for standard 8x8 chess board
            (coord[0] < 0 || coord[0] > 7) || (coord[1] < 0 || coord[1] > 7)
        end
        
        return possible_coordinates
    end

    def new_move_positions(pos)
        valid_moves = self.class.valid_moves(pos)
        valid_moves.reject! { |pos| @considered_positions.include?(pos) }
        valid_moves.each { |pos| @considered_positions << pos }             
        return valid_moves
    end

    def build_move_tree
        queue = [@root_node]

        until queue.empty?            
            first_node = queue.shift
            next_positions = self.new_move_positions(first_node.value)                        

            next_nodes = next_positions.map { |pos| PolyTreeNode.new(pos) }
            next_nodes.each do |node|
                node.parent=(first_node)
            end
            
            queue << next_nodes
            queue.flatten!
        end
    end
    
    def find_path(end_pos)
        end_node = @root_node.dfs(end_pos)
        trace_path_back(end_node)
    end

    def trace_path_back(end_node)
        positions = [end_node.value]

        until positions.include?(@root_node.value)
            positions << end_node.parent.value
            end_node = end_node.parent
        end

        positions.reverse
    end
end

if __FILE__ == $PROGRAM_NAME
    p KnightPathFinder.new([0,0]).find_path([6,2])
end