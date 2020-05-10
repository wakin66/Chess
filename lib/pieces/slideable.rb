module Slideable

    HORIZONTAL_DIRS = [[-1,0],[1,0],[0,-1],[0,1]].freeze
    DIAGONAL_DIRS = [[-1,-1],[-1,1],[1,-1],[1,1]].freeze

    def horizontal_dirs
        return HORIZONTAL_DIRS
    end

    def diagonal_dirs
        return DIAGONAL_DIRS
    end

    def moves
        steps = Array.new
        move_dirs.each do |dir|
            dx,dy = dir
            steps += grow_unblocked_moves_in_dir(dx,dy)
        end
        return steps
    end

    private

    def move_dirs
        #Overwritten by subclass
        raise NotImplementedError
    end

    def grow_unblocked_moves_in_dir(dx,dy)
        unblocked = Array.new
        next_pos = [pos.first+dx,pos.last+dy]
        while board.valid_pos?(next_pos) && (board[next_pos].empty? || board[next_pos].color != color)
            unblocked << next_pos
            break if !board[next_pos].empty? && board[next_pos].color != color
            next_pos = [next_pos.first+dx,next_pos.last+dy]
        end
        return unblocked
    end

end