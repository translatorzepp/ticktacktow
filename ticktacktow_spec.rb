require_relative "ticktacktow.rb"
require "rspec"

RSpec.describe "TickTackTow" do

  context "row" do
    before :each do
      @row = TickTackTow::Row.new
    end

    it "contains an array of #{TickTackTow::DIMENSION} squares" do
      expect(@row.contents.length).to eq(TickTackTow::DIMENSION)
      @row.contents.each do |row_element|
        expect(row_element).to be_an_instance_of(TickTackTow::Square)
      end
    end

    it "can pull out a square" do
      expect(@row.get_square(col: 1)).to eq(@row.contents[0])
      expect(@row.get_square(col: 1)).not_to eq(@row.contents[1])
    end
  end

  context "board" do
    before :each do
      @board = TickTackTow::Board.new
    end

    it "contains an array of #{TickTackTow::DIMENSION} rows" do
      expect(@board.contents.length).to eq(TickTackTow::DIMENSION)
      @board.contents.each do |board_element|
        expect(board_element).to be_an_instance_of(TickTackTow::Row)
      end
    end

    it "can play a mark" do
      @board.play(row: 3, col: 1, mark: TickTackTow::Oh.new)
      expect(@board._get_square(row: 3, col: 1).contents.mark).to eq(TickTackTow::Oh.new.mark)
      expect(@board._get_square(row: 1, col: 2).contents.mark).to eq(TickTackTow::Empty.new.mark)
      expect(@board.output).to eq([[" ", " ", " "], [" ", " ", " "], ["o", " ", " "]])
    end

    it "will not play a mark where one has already been played" do
      @board.play(row: 1, col: 1, mark: TickTackTow::Ex.new)
      expect(@board._get_square(row: 1, col: 1).contents.mark).to eq(TickTackTow::Ex.new.mark)
      @board.play(row: 1, col: 1, mark: TickTackTow::Oh.new)
      expect(@board._get_square(row: 1, col: 1).contents.mark).to eq(TickTackTow::Ex.new.mark)
    end

    it "can output" do
      expect(@board.output).to eq([[" ", " ", " "], [" ", " ", " "], [" ", " ", " "]])
    end

    it "can display" do
        # "   |   |  "
        # "--  --  --"
        # "   |   |  "
        # "--  --  --"
        # "   |   |  "
      @board.display

      @board.play(row: 1, col: 1, mark: TickTackTow::Oh.new)
      @board.play(row: 2, col: 2, mark: TickTackTow::Ex.new)
      @board.play(row: 1, col: 2, mark: TickTackTow::Oh.new)
      @board.play(row: 1, col: 3, mark: TickTackTow::Ex.new)
      @board.play(row: 3, col: 1, mark: TickTackTow::Oh.new)
      @board.play(row: 2, col: 1, mark: TickTackTow::Ex.new)
      @board.play(row: 2, col: 3, mark: TickTackTow::Oh.new)
      @board.play(row: 3, col: 3, mark: TickTackTow::Ex.new)
      @board.play(row: 3, col: 2, mark: TickTackTow::Oh.new)
      @board.display
    end
  end

  context "square" do
    before :each do
      @square = TickTackTow::Square.new
    end

    it "starts out empty" do
      expect(@square.contents.mark).to eq(TickTackTow::Empty.new.mark)
    end

    it "can become marked" do
      @square.place(TickTackTow::Ex.new)
      expect(@square.contents.mark).to eq(TickTackTow::Ex.new.mark)
    end

    it "cannot be re-marked" do
      @square.place(TickTackTow::Oh.new)
      @square.place(TickTackTow::Ex.new)
      expect(@square.contents.mark).to eq(TickTackTow::Oh.new.mark)
    end
  end
end
