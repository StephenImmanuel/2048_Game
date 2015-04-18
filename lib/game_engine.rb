class GameEngine
  attr_accessor :board, :modified

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
    @modified = false
    @board.each do |subarray|
      subarray.each_with_index do |value, columnIndex|
        ref_index = subarray.size - columnIndex - 1
        compare_index = ref_index - 1

        ref_value = subarray[ref_index]
        compare_value = subarray[compare_index]

        if ref_value.nil?
          subarray.delete_at(ref_index)
          subarray.push(nil)
          @modified = true
        elsif compare_value.nil? && (compare_index >= 0)
          subarray.delete_at(compare_index)
          subarray.push(nil)
          @modified = true
        elsif ref_value == compare_value
          subarray[ref_index] *= 2
          subarray[compare_index] = nil
          @modified = true
        end
      end
      subarray.compact!
    end
  end

  def move_right
    update_board

    @board.each_with_index do |subarray|
      subarray.unshift(nil) while subarray.count < 4
    end
  end

  def move_left
    @board.each_with_index do |subarray, rowIndex|
      @board[rowIndex] = subarray.reverse
    end

    update_board

    @board.each_with_index do |subarray, rowIndex|
      @board[rowIndex] = subarray.reverse
    end

    @board.each_with_index do |subarray|
      subarray.push(nil) while subarray.count < 4
    end
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
