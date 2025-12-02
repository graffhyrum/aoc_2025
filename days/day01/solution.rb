require_relative '../../lib/utils'

# Day 1 Solution - Dial Rotation Problem
# Simulates a dial (0-99) starting at position 50, processing rotation commands
# and counting how many times the dial passes through position 0.
class Solver
  # Part 1: Count zeros reached by dial movements (no additional zero counting logic)
  def self.solve_one(input)
    process_rotations(input) { |dial, direction, distance| 0 }
  end

  # Part 2: Count zeros including additional zeros calculated based on rotation distance
  # For distances > 1, calculates how many extra zeros are "passed through" during the rotation
  def self.solve_two(input)
    process_rotations(input) do |dial, direction, distance|
      if distance <= 1
        0  # No additional zeros for small movements
      else
        steps = distance - 1  # Steps beyond the immediate move
        # Calculate target position modulo for zero-crossing detection
        target_k_mod = direction == 'R' ? (100 - dial % 100) % 100 : dial % 100
        if target_k_mod == 0
          # Already at a zero boundary, count full rotations
          steps >= 100 ? (steps / 100).floor : 0
        else
          # Count how many times we cross zero boundaries during the move
          target_k_mod <= steps ? ((steps - target_k_mod) / 100).floor + 1 : 0
        end
      end
    end
  end

  private

  # Process rotation commands and count zero crossings
  # @param input [String] Input containing rotation commands (e.g., "R5", "L3")
  # @param block [Proc] Custom logic for calculating additional zeros per rotation
  # @return [Integer] Total count of zeros encountered
  def self.process_rotations(input, &block)
    lines = Utils.parse_lines(input)  # Parse input into individual command lines
    zero_count = 0  # Total zeros encountered
    dial = 50  # Dial starts at position 50

    lines.each do |line|
      direction = line[0]  # 'R' for right/clockwise, 'L' for left/counter-clockwise
      distance = line[1..].to_i  # Rotation distance (steps to move)

      # Call custom block to calculate additional zeros for this specific rotation
      additional = block.call(dial, direction, distance)
      zero_count += additional

      # Update dial position with wraparound (0-99 range)
      dial = direction == 'R' ? (dial + distance) % 100 : (dial - distance) % 100

      # Count if we landed exactly on zero
      zero_count += 1 if dial == 0
    end

    zero_count
  end
end