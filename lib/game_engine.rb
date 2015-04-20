class GameEngine
  attr_accessor :board, :board_updated

  def initialize(board)
    @board = board
    @empty_cell_location = []
  end

  def save_value_to_random_empty_location(cell_value)
    @board = @board.flatten
    @empty_cell_location = []

    @board.each_with_index do |value, index|
      @empty_cell_location.push(index) if value.nil?
    end

    @board[@empty_cell_location.sample] = \
      cell_value unless @empty_cell_location.empty?
    @board = @board.each_slice(4).to_a
  end

  def update_board
    @board_updated = false
    @board.each do |subarray|
      subarray.each_with_index do |value, column_index|
        ref_index = subarray.size - column_index - 1
        compare_index = ref_index - 1

        ref_value = subarray[ref_index]
        compare_value = subarray[compare_index]

        if ref_value.nil?
          subarray.delete_at(ref_index)
          subarray.push(nil)
          @board_updated = true
        elsif compare_value.nil? && (compare_index >= 0)
          subarray.delete_at(compare_index)
          subarray.push(nil)
          @board_updated = true
        elsif ref_value == compare_value
          subarray[ref_index] *= 2
          subarray[compare_index] = nil
          @board_updated = true
        end
      end
      subarray.compact!
    end
  end

  def reverse_board
    @board.each_with_index do |subarray, row_index|
      @board[row_index] = subarray.reverse
    end
  end

  def move_empty_cell_to_begining
    @board.each_with_index do |subarray|
      subarray.unshift(nil) while subarray.count < 4
    end
  end

  def move_empty_cell_to_end
    @board.each_with_index do |subarray|
      subarray.push(nil) while subarray.count < 4
    end
  end

  def move_right
    update_board
    move_empty_cell_to_begining
  end

  def move_left
    reverse_board
    update_board
    reverse_board
    move_empty_cell_to_end
  end

  def move_down
    @board = @board.transpose
    move_right
    @board = @board.transpose
  end

  def move_up
    @board = @board.transpose
    move_left
    @board = @board.transpose
  end
end
