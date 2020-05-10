require_relative 'player.rb'

class ComputerPlayer < Player

    def initialize(color,display)
        super
    end

    def make_move(board)
        pieces = board.color_pieces(color)
        piece = get_piece(pieces)
        start_pos = piece.pos
        end_pos = piece.valid_moves[rand(piece.valid_moves.count)]
        board.move_piece(color,start_pos,end_pos)
    end

    private
    
    def get_piece(pieces)
        valid_pieces = pieces.select {|piece| !piece.valid_moves.empty?}
        valid_pieces[rand(valid_pieces.count)]
    end

end