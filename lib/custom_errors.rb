class Error < StandardError
end

class PositionError < Error
    def initialize(msg = "Invalid Position")
        super
    end
end

class StartPositionError < PositionError
    def initialize(msg = "Invalid Start Position")
        super
    end
end

class EndPositionError < PositionError
    def initialize(msg = "Invalid End Position")
        super
    end
end

class NoPieceError < Error
    def initialize(msg = "No piece at specified position")
        super
    end
end

class OccupiedPosition < PositionError
    def initialize(msg = "There is already a pice there")
        super
    end
end