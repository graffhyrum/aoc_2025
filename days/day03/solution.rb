class Solver
  def self.solve_one(input)
    solve(input, 2)
  end

  def self.solve_two(input)
    solve(input, 12)
  end

  def self.solve(input, num_batteries)
    input.strip.split("\n").sum { |line| find_best_number(line, num_batteries) }
  end

  private

  def self.find_best_number(line, num_batteries)
    digits = line.chars.map(&:to_i)
    return 0 if digits.length < num_batteries

    selected_positions = find_optimal_positions(digits, num_batteries)
    selected_positions.map { |pos| digits[pos] }.join.to_i
  end

  def self.find_optimal_positions(digits, num_batteries)
    positions = []
    search_start = 0

    num_batteries.times do |i|
      search_end = digits.length - (num_batteries - i)
      slice = digits[search_start..search_end]

      max_val = slice.max
      next_pos = search_start + slice.index(max_val)

      positions << next_pos
      search_start = next_pos + 1
    end

    positions
  end
end
