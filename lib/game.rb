require_relative 'board.rb'
require_relative 'players.rb'
require_relative 'display.rb'

class Game
    attr_reader :board, :display, :players, :current_player

    def initialize
        @board = Board.new
        @display = Display.new(@board)
        @players = {
            :white => HumanPlayer.new(:white,display),
            :black => ComputerPlayer.new(:black,display)
        }
        @current_player = :black
    end

    def play
        until board.checkmate?(:black) || board.checkmate?(:white)
            swap_turn!
            players[current_player].make_move(board)
        end
        notify_players
    end

    private

    def notify_players
        losing_player = current_player == :white ? :black : :white
        system('clear')
        display.render
        puts "Congratulations #{current_player}! You have checkmated #{losing_player}!"
        sleep(5)
        exit 0
    end

    def swap_turn!
        @current_player = @current_player == :white ? :black : :white
    end

end

if __FILE__ == $PROGRAM_NAME
    game = Game.new
    game.play
end