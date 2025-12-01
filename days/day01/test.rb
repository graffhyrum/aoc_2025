require 'minitest/autorun'
require_relative 'part1'
require_relative 'part2'

class TestDay01 < Minitest::Test
  def test_part1_sample
    sample_input = "line1\nline2\nline3"
    expected = 3
    assert_equal expected, Part1.solve(sample_input)
  end

  def test_part1_empty_input
    sample_input = ""
    expected = 0
    assert_equal expected, Part1.solve(sample_input)
  end

  def test_part2_sample
    sample_input = "line1\nline2\nline3"
    expected = 6
    assert_equal expected, Part2.solve(sample_input)
  end

  def test_part2_empty_input
    sample_input = ""
    expected = 0
    assert_equal expected, Part2.solve(sample_input)
  end
end