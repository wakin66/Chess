module Stepable

    def moves
        list = Array.new
        move_diffs.each do |move|
            next_move = [pos.first+move.first,pos.last+move.last]
            list << next_move if board.valid_pos?(next_move) && (board[next_move].empty? || board[next_move].color != color)
        end
        return list
    end

    private

    def move_diffs
        #Overwritten by subclass
        raise NotImplementedError
    end
end