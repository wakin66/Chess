require_relative 'piece'
require 'singleton'

class NullPiece < Piece
    include Singleton
    attr_reader :symbol

    def initialize
        @symbol = " "
        @color = :none
    end

    def empty?
        return true
    end

    def moves
        return Array.new
    end

end