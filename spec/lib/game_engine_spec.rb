require 'spec_helper'
require 'game_configuration'
require 'game_engine'

describe GameEngine do
  include GameConfiguration

  it 'game engine has the board initialized' do
    game_engine = GameEngine.new GameConfiguration.board
    game_engine.board.should == Array.new(4) { Array.new(4) }
  end

  it 'when right key is pressed' do
    GameConfiguration.setting do
      board [
        [2, nil, nil, 2], [nil, 2, 2, nil],
        [2, 2, 2, 2], [2, 2, 2, nil]
      ]
    end
    game_engine = GameEngine.new GameConfiguration.board
    game_engine.move_right
    game_engine.board.should == [
      [nil, nil, nil, 4], [nil, nil, nil, 4],
      [nil, nil, 4, 4], [nil, nil, 2, 4]
    ]
    game_engine.move_right
    game_engine.board.should == [
      [nil, nil, nil, 4], [nil, nil, nil, 4],
      [nil, nil, nil, 8], [nil, nil, 2, 4]
    ]
  end

  it 'when left key is pressed' do
    GameConfiguration.setting do
      board [
        [2, nil, nil, 2], [nil, nil, 2, 2],
        [2, 2, 2, 2], [nil, nil, nil, nil]
      ]
    end
    game_engine = GameEngine.new GameConfiguration.board
    game_engine.move_left
    game_engine.board.should == [
      [4, nil, nil, nil], [4, nil, nil, nil],
      [4, 4, nil, nil], [nil, nil, nil, nil]
    ]
    game_engine.move_left
    game_engine.board.should == [
      [4, nil, nil, nil], [4, nil, nil, nil],
      [8, nil, nil, nil], [nil, nil, nil, nil]
    ]
  end

  it 'when right key and left key are pressed consecutively' do
    GameConfiguration.setting do
      board [
        [2, nil, nil, 2], [nil, nil, 2, 2],
        [2, 2, 2, 2], [nil, nil, nil, nil]
      ]
    end
    game_engine = GameEngine.new GameConfiguration.board
    game_engine.move_right
    game_engine.board.should == [
      [nil, nil, nil, 4], [nil, nil, nil, 4],
      [nil, nil, 4, 4], [nil, nil, nil, nil]
    ]
    game_engine.move_left
    game_engine.board.should == [
      [4, nil, nil, nil], [4, nil, nil, nil],
      [8, nil, nil, nil], [nil, nil, nil, nil]
    ]
  end

  it 'when left key and right key are pressed consecutively' do
    GameConfiguration.setting do
      board [
        [2, nil, nil, 2], [nil, nil, 2, 2],
        [2, 2, 2, 2], [nil, nil, nil, nil]
      ]
    end
    game_engine = GameEngine.new GameConfiguration.board
    game_engine.move_left
    game_engine.board.should == [
      [4, nil, nil, nil], [4, nil, nil, nil],
      [4, 4, nil, nil], [nil, nil, nil, nil]
    ]
    game_engine.move_right
    game_engine.board.should == [
      [nil, nil, nil, 4], [nil, nil, nil, 4],
      [nil, nil, nil, 8], [nil, nil, nil, nil]
    ]
  end

  it 'when down key is pressed' do
    GameConfiguration.setting do
      board [
        [2, nil, nil, 2], [nil, nil, 2, 2],
        [2, 2, 2, 2], [nil, nil, nil, nil]
      ]
    end
    game_engine = GameEngine.new GameConfiguration.board
    game_engine.move_down
    game_engine.board.should == [
      [nil, nil, nil, nil], [nil, nil, nil, nil],
      [nil, nil, nil, 2], [4, 2, 4, 4]
    ]

    GameConfiguration.setting do
      board [
        [4, nil, nil, 2], [nil, nil, nil, nil],
        [nil, nil, nil, 2], [4, 2, 4, 4]
      ]
    end
    game_engine = GameEngine.new GameConfiguration.board
    game_engine.move_down
    game_engine.board.should == [
      [nil, nil, nil, nil], [nil, nil, nil, nil],
      [nil, nil, nil, 4], [8, 2, 4, 4]
    ]
  end

  it 'when right key is pressed followed by down keypress' do
    GameConfiguration.setting do
      board [
        [2, nil, nil, 2], [nil, nil, 2, 2],
        [2, 2, 2, 2], [nil, nil, nil, nil]
      ]
    end
    game_engine = GameEngine.new GameConfiguration.board
    game_engine.move_down
    game_engine.move_right
    game_engine.board.should == [
      [nil, nil, nil, nil], [nil, nil, nil, nil],
      [nil, nil, nil, 2], [nil, 4, 2, 8]
    ]
  end

  it 'when up key is pressed' do
    GameConfiguration.setting do
      board [
        [2, nil, nil, 2], [nil, nil, 2, 2],
        [2, 2, 2, 2], [nil, nil, nil, nil]
      ]
    end
    game_engine = GameEngine.new GameConfiguration.board
    game_engine.move_up
    game_engine.board.should == [
      [4, 2, 4, 4], [nil, nil, nil, 2],
      [nil, nil, nil, nil], [nil, nil, nil, nil]
    ]

    GameConfiguration.setting do
      board [
        [4, nil, nil, 2], [nil, nil, nil, nil],
        [nil, nil, nil, 2], [4, 2, 4, 4]
      ]
    end
    game_engine = GameEngine.new GameConfiguration.board
    game_engine.move_up
    game_engine.board.should == [
      [8, 2, 4, 4], [nil, nil, nil, 4],
      [nil, nil, nil, nil], [nil, nil, nil, nil]
    ]
  end

  it 'when left key is pressed followed by up keypress' do
    GameConfiguration.setting do
      board [
        [2, nil, nil, 2], [nil, nil, 2, 2],
        [2, 2, 2, 2], [nil, nil, nil, nil]
      ]
    end
    game_engine = GameEngine.new GameConfiguration.board
    game_engine.move_up
    game_engine.move_left
    game_engine.board.should == [
      [4, 2, 8, nil], [2, nil, nil, nil],
      [nil, nil, nil, nil], [nil, nil, nil, nil]
    ]
  end

  it 'setting board with random values' do
    GameConfiguration.setting do
      board [
        [nil, nil, nil, nil], [nil, nil, nil, nil]
      ]
    end
    game_engine = GameEngine.new GameConfiguration.board
    game_engine.save_value_to_random_empty_location 2
    game_engine.board.flatten.compact.should == [2]
    game_engine.save_value_to_random_empty_location 2
    game_engine.board.flatten.compact.should == [2, 2]
  end

  it 'when board has no free cell, no ramdon value is set' do
    GameConfiguration.setting do
      board [
        [2, 2, 2, 2], [2, 2, 2, 2]
      ]
    end
    game_engine = GameEngine.new GameConfiguration.board
    game_engine.save_value_to_random_empty_location 5
    game_engine.board.flatten.compact.should == [2, 2, 2, 2, 2, 2, 2, 2]
  end

  it 'ramdon value is set, when only one free cell' do
    GameConfiguration.setting do
      board [
        [2, 2, 2, 2], [2, 2, 5, 2]
      ]
    end
    game_engine = GameEngine.new GameConfiguration.board
    game_engine.save_value_to_random_empty_location 5
    game_engine.board.flatten.compact.should == [2, 2, 2, 2, 2, 2, 5, 2]
  end
end
