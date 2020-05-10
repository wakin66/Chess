class Piece
    attr_reader :color, :board
    attr_accessor :pos

    def initialize(color,board,pos)
        @color = color
        @board = board
        @pos = pos
    end

    def to_s
        " #{symbol} "
    end

    def empty?
        return false
    end

    def moves
        #Subclass implements this
        raise NotImplementedError
    end

    def pos=(val)
        @pos = val
    end

    def symbol
        #Subclass implements this
        raise NotImplementedError
    end

    def valid_moves
        moves.select {|move| !move_into_check?(move)}
    end

    private
    
    def move_into_check?(end_pos)
        new_board = board.dup
        new_board.move_piece!(color,pos,end_pos)
        new_board.in_check?(color)
    end
end