require 'colorize'
require_relative 'cursor'

class Display
    attr_reader :board, :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([6,3], board)
    end

    def render
        background = :light_black
        cursor_background = :light_red
        board.rows.each.with_index do |row,idx_x|
            row.each.with_index do |sqr,idx_y|
                if cursor.selected == [idx_x,idx_y]
                    print sqr.to_s.colorize(:background => :light_green)
                elsif cursor.cursor_pos == [idx_x,idx_y]
                    print sqr.to_s.colorize(:background => cursor_background)
                else
                    print sqr.to_s.colorize(:background => background)
                end
                background = background == :light_black ? :light_blue : :light_black
            end
            background = background == :light_black ? :light_blue : :light_black
            puts
        end
        return nil
    end

end