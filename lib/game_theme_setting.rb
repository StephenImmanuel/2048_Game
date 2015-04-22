module GameThemeSetting

  DEFAULT_THEME = {
    0 => {:color => :light_white, :background => :black},
    2 => {:color => :light_white, :background => :light_black},
    4 => {:color => :light_white, :background => :cyan},
    8 => {:color => :light_white, :background => :light_magenta},
    16 => {:color => :light_white, :background => :blue},
    32 => {:color => :light_white, :background => :light_blue},
    64 => {:color => :light_white, :background => :yellow},
    128 => {:color => :light_white, :background => :light_yellow},
    256 => {:color => :light_white, :background => :green},
    512 => {:color => :light_white, :background => :light_green},
    1024 => {:color => :light_white, :background => :red},
    2048 => {:color => :light_white, :background => :light_red}
  }

  def create_cell_with_value(num)
    string_diff = 6 - num.to_s.length
    cell = ' ' * string_diff + num.to_s
  end

  def apply_theme(num)
    cell = GameThemeSetting.create_cell_with_value num

    theme = DEFAULT_THEME[num.to_i] 
   
    font_color = theme[:color]
    backgound_color = "on_#{theme[:background]}"
   
    if font_color && backgound_color
      cell.colorize(font_color).send(backgound_color)
    end
  end

  module_function :apply_theme, :create_cell_with_value
end
