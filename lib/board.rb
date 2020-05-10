require_relative 'pieces'
require_relative 'custom_errors'

class Board
    attr_reader :rows

    def initialize(dup = false)
        @rows = Array.new(8) {Array.new(8)}
        @sentinel = NullPiece.instance
        fill_board if !dup
    end

    def fill_board
        (0..7).each do |x|
            (0..7).each do |y|
                pos = [x,y]
                if [2,3,4,5].include? x #nullPieces
                    self[pos] = NullPiece.instance
                elsif x == 1 #Black Pawns
                    self[pos] = Pawn.new(:black,self,pos)
                elsif x == 6 #White Pawns
                    self[pos] = Pawn.new(:white,self,pos)
                elsif [0,7].include? y #Rook
                    self[pos] = Rook.new(:black,self,pos) if x == 0
                    self[pos] = Rook.new(:white,self,pos) if x == 7
                elsif [1,6].include? y #Knight
                    self[pos] = Knight.new(:black,self,pos) if x == 0
                    self[pos] = Knight.new(:white,self,pos) if x == 7
                elsif [2,5].include? y #Bishop
                    self[pos] = Bishop.new(:black,self,pos) if x == 0
                    self[pos] = Bishop.new(:white,self,pos) if x == 7
                elsif y == 3 #Queen
                    self[pos] = Queen.new(:black,self,pos) if x == 0
                    self[pos] = Queen.new(:white,self,pos) if x == 7
                else #King
                    self[pos] = King.new(:black,self,pos) if x == 0
                    self[pos] = King.new(:white,self,pos) if x == 7
                end
            end
        end
    end

    def [](pos)
        x,y = pos
        @rows[x][y]
    end

    def []=(pos,val)
        x,y = pos
        @rows[x][y] = val
    end

    def move_piece(color,start_pos,end_pos)
        raise NoPieceError if self[start_pos].empty?
        raise EndPositionError.new "Cannot move piece to that location." if !self[start_pos].moves.include?(end_pos)
        raise EndPositionError.new "That move would leave you in check." if !self[start_pos].valid_moves.include?(end_pos)
        piece_to_move = self[start_pos]
        self[start_pos] = NullPiece.instance
        self[end_pos] = piece_to_move
        piece_to_move.pos = end_pos
    end

    def valid_pos?(pos)
        x,y = pos
        return false if ![0,1,2,3,4,5,6,7].include? x
        return false if ![0,1,2,3,4,5,6,7].include? y
        return true
    end

    def add_piece(piece,pos)
        self[pos] = piece
    end

    def checkmate?(color)
        find_king(color) == nil || (in_check?(color) && color_pieces(color).all? {|piece| piece.valid_moves.empty?})
    end

    def in_check?(color)
        pieces.any? {|piece| piece.moves.include? find_king(color).pos}
    end

    def find_king(color)
        pieces.select {|piece| piece.class == King && piece.color == color}.first
        rescue
            return nil
    end

    def pieces
        list = Array.new
        (0..7).each do |x|
            (0..7).each do |y|
                pos = [x,y]
                list << self[pos] if !self[pos].empty? && !list.include?(self[pos])
            end
        end
        return list
    end

    def color_pieces(color)
        list = pieces.select {|piece| piece.color == color}
        return list
    end

    def dup
        new_board = Board.new(true)
        (0..7).each do |idx_x|
            (0..7).each do |idx_y|
                new_pos = [idx_x,idx_y]
                piece = self[new_pos]
                if piece.class == NullPiece
                    new_board.add_piece(NullPiece.instance,new_pos)
                else
                    new_class = piece.class
                    new_color = piece.color
                    new_piece = new_class.new(new_color,new_board,new_pos)
                    new_board.add_piece(new_piece,new_pos)
                end
            end
        end
        return new_board
    end

    def move_piece!(color,start_pos,end_pos)
        raise NoPieceError if self[start_pos].empty?
        raise EndPositionError.new "Cannot move piece to that location." if !self[start_pos].moves.include?(end_pos)
        piece_to_move = self[start_pos]
        self[start_pos] = NullPiece.instance
        self[end_pos] = piece_to_move
        piece_to_move.pos = end_pos
    end

end