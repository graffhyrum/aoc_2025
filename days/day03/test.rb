require 'minitest/autorun'
require_relative 'solution'

class TestDay03 < Minitest::Test
  def test_solve_one_sample
    sample_input = "987654321111111\n811111111111119\n234234234234278\n818181911112111"
    expected = 357
    assert_equal expected, Solver.solve_one(sample_input)
  end

  def test_solve_front
    input = "987654321111111"
    expected = 98
    assert_equal expected, Solver.solve_one(input)
  end

  def test_solve_ends
    input = "811111111111119"
    expected = 89
    assert_equal expected, Solver.solve_one(input)
  end

  def test_solve_back
    input = "234234234234278"
    expected = 78
    assert_equal expected, Solver.solve_one(input)
  end

  def test_solve_mix
    input = "818181911112111"
    expected = 92
    assert_equal expected, Solver.solve_one(input)
  end

  def test_solve_two_sample
    sample_input = "987654321111111\n811111111111119\n234234234234278\n818181911112111"
    expected = 3121910778619
    assert_equal expected, Solver.solve_two(sample_input)
  end
end
