require 'minitest/autorun'
require_relative '../lib/utils'

class TestUtils < Minitest::Test
  def test_parse_lines
    input = "line1\nline2\nline3"
    expected = ["line1", "line2", "line3"]
    assert_equal expected, Utils.parse_lines(input)
  end

  def test_parse_lines_strips_whitespace
    input = "  line1  \n  line2  \n"
    expected = ["line1  ", "  line2"]
    assert_equal expected, Utils.parse_lines(input)
  end

  def test_parse_integers
    input = "1\n2\n3"
    expected = [1, 2, 3]
    assert_equal expected, Utils.parse_integers(input)
  end

  def test_parse_grid
    input = "abc\ndef"
    expected = [%w[a b c], %w[d e f]]
    assert_equal expected, Utils.parse_grid(input)
  end

  def test_manhattan_distance
    assert_equal 7, Utils.manhattan_distance(0, 0, 3, 4)
    assert_equal 0, Utils.manhattan_distance(1, 1, 1, 1)
    assert_equal 2, Utils.manhattan_distance(-1, -1, 0, 0)
  end

  def test_grid_neighbors
    grid = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]

    # Center cell
    neighbors = Utils.grid_neighbors(grid, 1, 1, include_diagonal: false)
    expected = [[0, 1], [2, 1], [1, 0], [1, 2]]
    assert_equal expected.sort, neighbors.sort

    # Corner cell
    neighbors = Utils.grid_neighbors(grid, 0, 0, include_diagonal: false)
    expected = [[1, 0], [0, 1]]
    assert_equal expected.sort, neighbors.sort
  end

  def test_grid_neighbors_with_diagonal
    grid = [[1, 2], [3, 4]]

    neighbors = Utils.grid_neighbors(grid, 0, 0, include_diagonal: true)
    expected = [[1, 0], [0, 1], [1, 1]]
    assert_equal expected.sort, neighbors.sort
  end

  def test_gcd
    assert_equal 6, Utils.gcd(12, 18)
    assert_equal 1, Utils.gcd(7, 11)
    assert_equal 5, Utils.gcd(5, 0)
  end

  def test_lcm
    assert_equal 36, Utils.lcm(12, 18)
    assert_equal 77, Utils.lcm(7, 11)
  end

  def test_extract_numbers
    assert_equal [123, -45, 67], Utils.extract_numbers("abc123def-45ghi67")
    assert_equal [], Utils.extract_numbers("no numbers here")
  end
end