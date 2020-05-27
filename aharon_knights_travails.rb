require_relative "./aharon_PolyTreeNode.rb"

class KnightPathFinder
    def initialize(start_pos)
        @start_pos = start_pos
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
    end

    def self.valid_moves(pos)
        my_row = @start_pos[0]
        my_col = @start_pos[1]
        
        possible_coordinates = [ 
            [my_row+2, my_col+1]
            [my_row+1, my_col+2]
            [my_row-1, my_col+2]
            [my_row-2, my_col+1]
            [my_row-2, my_col-1]
            [my_row-1, my_col-2]
            [my_row+1, my_col-2]
            [my_row+2, my_col-1]
        ]
    end

    def new_move_positions(pos)
        valid_moves = self.class.valid_moves(pos)
        valid_moves.reject! { |pos| @considered_positions.include?(pos) }
        @considered_positions << valid_moves
        return valid_moves
    end
end