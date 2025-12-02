require_relative '../../lib/utils'

# Day 1 Solution
class Solver
  def self.solve_one(input)
    process_rotations(input) { |dial, direction, distance| 0 }
  end

  def self.solve_two(input)
    process_rotations(input) do |dial, direction, distance|
      if distance <= 1
        0
      else
        steps = distance - 1
        target_k_mod = direction == 'R' ? (100 - dial % 100) % 100 : dial % 100
        if target_k_mod == 0
          steps >= 100 ? (steps / 100).floor : 0
        else
          target_k_mod <= steps ? ((steps - target_k_mod) / 100).floor + 1 : 0
        end
      end
    end
  end

  private

  def self.process_rotations(input, &block)
    lines = Utils.parse_lines(input)
    zero_count = 0
    dial = 50
    lines.each do |line|
      direction = line[0]
      distance = line[1..].to_i
      additional = block.call(dial, direction, distance)
      zero_count += additional
      dial = direction == 'R' ? (dial + distance) % 100 : (dial - distance) % 100
      zero_count += 1 if dial == 0
    end
    zero_count
  end
end