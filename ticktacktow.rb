require 'pry'

module TickTackTow
  DIMENSION = 3

  class Playspace
    def initialize(element)
      @contents = []
      TickTackTow::DIMENSION.times do |_|
        @contents << element.new
      end
    end

    def output
      @contents.map(&:output)
    end
  end

  class Board < Playspace
    attr_reader :contents #only for testing

    def initialize
      super(Row)
    end

    def play(row:, col:, mark:)
      _get_square(row: row, col: col).place(mark)
    end

    def _get_square(row:, col:)
      row = @contents[row - 1]
      row.get_square(col: col)
    end

    def display
      puts "\n"
      array = self.output
      array.each do |element_output|
        puts " " + element_output.join(' | ') + "  "
        puts "--  --  --"
      end
    end
  end

  class Row < Playspace
    attr_reader :contents #only for testing

    def initialize
      super(Square)
    end

    def get_square(col:)
      @contents[col - 1]
    end
  end

  class Square
    attr_reader :contents #only for testing

    def initialize
      @contents = Empty.new
      @played = false
    end

    def place(mark)
      if !@played
        @contents = mark
        @played = true
      end
    end

    def output
      @contents.mark
    end
  end

  class Empty
    def mark
      " "
    end
  end

  class Ex
    def mark
      "x"
    end
  end

  class Oh
    def mark
      "o"
    end
  end
end

