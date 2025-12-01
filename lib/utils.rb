module Utils
  # Input parsing helpers
  def self.parse_lines(input)
    input.strip.split("\n")
  end

  def self.parse_integers(input)
    parse_lines(input).map(&:to_i)
  end

  def self.parse_grid(input)
    parse_lines(input).map { |line| line.chars }
  end

  def self.parse_csv_integers(input)
    parse_lines(input).map { |line| line.split(',').map(&:to_i) }
  end

  # Common AoC algorithms
  def self.manhattan_distance(x1, y1, x2, y2)
    (x1 - x2).abs + (y1 - y2).abs
  end

  def self.grid_neighbors(grid, row, col, include_diagonal: false)
    directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    directions += [[-1, -1], [-1, 1], [1, -1], [1, 1]] if include_diagonal

    neighbors = []
    directions.each do |dr, dc|
      nr, nc = row + dr, col + dc
      neighbors << [nr, nc] if nr >= 0 && nr < grid.size && nc >= 0 && nc < grid[0].size
    end
    neighbors
  end

  # File I/O helpers
  def self.read_input(day, part)
    filename = "days/day#{day.to_s.rjust(2, '0')}/input#{part}.txt"
    File.read(filename)
  rescue Errno::ENOENT
    raise "Input file not found: #{filename}"
  end

  # Math utilities
  def self.gcd(a, b)
    b == 0 ? a : gcd(b, a % b)
  end

  def self.lcm(a, b)
    (a * b) / gcd(a, b)
  end

  # String utilities
  def self.extract_numbers(str)
    str.scan(/-?\d+/).map(&:to_i)
  end
end