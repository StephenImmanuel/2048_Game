require 'io/console'
require 'pp'
require 'colorize'
require './lib/game_engine'
require './lib/game_configuration'
require './lib/game_theme_setting'

class PlayGame
  def initialize
    @engine = GameEngine.new GameConfiguration.board
    @engine.save_value_to_random_empty_location 2
  end

  def display_board
    system('clear')
 
    @engine.save_value_to_random_empty_location 2

    @engine.board.each do |subarray|
      puts "\n"
      subarray.each do |value|
        print GameThemeSetting.apply_theme(value) + ' '
      end
      puts "\n"
    end
  end

  def read_char
    STDIN.echo = false
    STDIN.raw!

    input = STDIN.getc.chr
    if input == "\e"
      input << STDIN.read_nonblock(3) rescue nil
      input << STDIN.read_nonblock(2) rescue nil
    end

    ensure
      STDIN.echo = true
      STDIN.cooked!
      return input
  end

  def show_single_key
    c = read_char

    case c
    when "\e[A"
      @engine.move_up
    when "\e[B"
      @engine.move_down
    when "\e[C"
      @engine.move_right
    when "\e[D"
      @engine.move_left
    else
      puts 'Exiting game'
      exit 0
    end

    display_board

    abort 'Congratulation on winning :)' if @engine.board.to_s.include?(GameConfiguration.winning_score.to_s)
    abort 'Sorry no more valid move. Exiting game :(' unless @engine.board_updated
  end

  def start
    show_single_key while true
  end
end

new_game = PlayGame.new
new_game.start
