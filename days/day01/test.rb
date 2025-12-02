require 'minitest/autorun'
require_relative 'solution'

class TestDay01 < Minitest::Test
  def test_solve_one_sample
    sample_input = "L68
L30
R48
L5
R60
L55
L1
L99
R14
L82"
    expected = 3
    assert_equal expected, Solver.solve_one(sample_input)
  end

  def test_solve_two_sample
    sample_input = "L68
L30
R48
L5
R60
L55
L1
L99
R14
L82"
    expected = 6
    assert_equal expected, Solver.solve_two(sample_input)
  end

  # Additional tests for part 1
  def test_solve_one_no_zeros
    input = "R10\nL10"
    # R10: 50+10=60 !=0, L10:60-10=50!=0
    assert_equal 0, Solver.solve_one(input)
  end

  def test_solve_one_single_zero
    input = "R50"
    # 50+50=100%100=0
    assert_equal 1, Solver.solve_one(input)
  end

  def test_solve_one_multiple_zeros
    input = "R50\nL50"
    # First: 50+50=0, count 1; Second: 0-50=-50%100=50!=0, total 1
    assert_equal 1, Solver.solve_one(input)
  end

  def test_solve_one_wrap_around
    input = "R60\nL60"
    # R60:50+60=110%100=10!=0; L60:10-60=-50%100=50!=0
    assert_equal 0, Solver.solve_one(input)
  end

  def test_solve_one_large_distance
    input = "R150"
    # 50+150=200%100=0
    assert_equal 1, Solver.solve_one(input)
  end

  # Additional tests for part 2
  def test_solve_two_no_zeros
    input = "R1\nL1"
    # R1:50+1=51!=0, during: none; L1:51-1=50!=0, during: none
    assert_equal 0, Solver.solve_two(input)
  end

  def test_solve_two_during_only
    input = "R100"
    # From 50, R100: passes 0 at step 50 (50+50=100%100=0), ends at 50+100%100=50!=0
    assert_equal 1, Solver.solve_two(input)
  end

  def test_solve_two_end_only
    input = "R50"
    # From 50, R50: during k=1..49, (50+k)%100==0? k=50>49 no; ends at 0
    assert_equal 1, Solver.solve_two(input)
  end

  def test_solve_two_both
    input = "L50"
    # From 50, L50: during k=1..49, (50-k)%100==0? 50-k==0 => k=50>49 no; ends at 0
    assert_equal 1, Solver.solve_two(input)
  end

  def test_solve_two_multiple_passes
    input = "R200"
    # From 50, R200: passes 0 at k=50,150 (50+50=0, 50+150=200%100=0), ends at 50+200%100=50!=0
    assert_equal 2, Solver.solve_two(input)
  end

  def test_solve_two_large_distance
    input = "R1000"
    # From 50, R1000: passes 0 every 100 steps starting at k=50, up to k=950 (50+9*100=950<=999)
    # 10 times, ends at 50+1000%100=50!=0
    assert_equal 10, Solver.solve_two(input)
  end

  def test_solve_two_left_large
    input = "L1000"
    # From 50, L1000: passes 0 at k=50,150,...,950 (50-50=0, 50-150=-100%100=0, etc.)
    # Same 10 times, ends at 50-1000%100=50!=0
    assert_equal 10, Solver.solve_two(input)
  end

  def test_solve_two_small_distance
    input = "R1\nL2"
    # R1: during none, end 51!=0; L2: during k=1,51-1=50!=0, end 51-2=49!=0
    assert_equal 0, Solver.solve_two(input)
  end

  def test_solve_two_cross_zero_left
    input = "L2"
    # From 50, L2: during k=1,50-1=49!=0; end 50-2=48!=0
    assert_equal 0, Solver.solve_two(input)
  end

  def test_solve_two_from_zero
    input = "R50\nR1"
    # First R50: ends at 0; Second from 0, R1: during none, end 1!=0
    assert_equal 1, Solver.solve_two(input)
  end

end