module GameConfiguration
  extend self

  def parameter(*names)
    names.each do |name|
      attr_accessor name

      define_method name do |*values|
        value = values.first
        value ? self.send("#{name}=", value) : instance_variable_get("@#{name}")
      end
    end
  end

  def setting(&block)
    instance_eval(&block)
  end
end

GameConfiguration.setting do
  parameter :board
  parameter :winning_score
end

# Default settings for the game
GameConfiguration.setting do
  board Array.new(4) { Array.new(4) }
  winning_score 2048
end
