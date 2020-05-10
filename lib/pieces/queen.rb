require_relative 'piece'
require_relative 'slideable'

class Queen < Piece
    include Slideable

    def initialize(color,board,pos)
        super
    end

    def symbol
        '♛'.colorize(color)
    end

    protected

    def move_dirs
        horizontal_dirs + diagonal_dirs
    end

end