require 'minitest/autorun'
require_relative 'solution'

class TestDay00 < Minitest::Test
  def test_solve_one_sample
    sample_input = "line1\nline2\nline3"
    expected = 3
    assert_equal expected, Solver.solve_one(sample_input)
  end

  def test_solve_one_empty_input
    sample_input = ""
    expected = 0
    assert_equal expected, Solver.solve_one(sample_input)
  end

  def test_solve_two_sample
    sample_input = "line1\nline2\nline3"
    expected = 6
    assert_equal expected, Solver.solve_two(sample_input)
  end

  def test_solve_two_empty_input
    sample_input = ""
    expected = 0
    assert_equal expected, Solver.solve_two(sample_input)
  end
end