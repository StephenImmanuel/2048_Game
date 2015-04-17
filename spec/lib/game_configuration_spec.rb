require 'spec_helper'
require 'game_configuration'

describe GameConfiguration do
  include GameConfiguration

  it 'should return a 4 X 4 array' do
    GameConfiguration.board.should == Array.new(4) { Array.new(4) }
  end

  it 'final winning score should return 2048' do
    GameConfiguration.winning_score.should == 2048
  end

  it 'should be able to modify game settings' do
    GameConfiguration.setting do
      winning_score 128
    end

    GameConfiguration.winning_score.should == 128
  end
end
