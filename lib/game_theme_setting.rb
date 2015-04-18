module GameThemeSetting
  def create_cell_with_value(num)
    string_diff = 6 - num.to_s.length
    text = ' ' * string_diff + num.to_s
  end

  def apply_theme(num)
    text = GameThemeSetting.create_cell_with_value num

    case num
    when nil
      text.colorize(:light_white).on_black
    when 2
      text.colorize(:light_white).on_light_black
    when 4
      text.colorize(:light_white).on_cyan
    when 8
      text.colorize(:light_white).on_light_magenta
    when 16
      text.colorize(:light_white).on_blue
    when 32
      text.colorize(:light_white).on_light_blue
    when 64
      text.colorize(:light_white).on_yellow
    when 128
      text.colorize(:light_white).on_light_yellow
    when 256
      text.colorize(:light_white).on_green
    when 512
      text.colorize(:light_white).on_light_green
    when 1024
      text.colorize(:light_white).on_red
    when 2048
      text.colorize(:light_white).on_light_red
    end
  end

  module_function :apply_theme, :create_cell_with_value
end
