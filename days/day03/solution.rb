class Solver
  def self.solve_one(input)
    # Parse input as needed
    lines = input.strip.split("\n")

    # Each line is a row of batteries
    # Find the highest number that can be made with
    # two non-sequential digits
    # Two pointers, start from the back.
    # Calculate total sum of best values
    result = lines.map do |line|
      bank_ints = line.chars.map(&:to_i)
      last = bank_ints.length - 1
      left = 0
      right = 1
      bank_ints.each_with_index do |val, idx|
        # find highest tens
        if idx == last
          next # skip last digit
        elsif val == 9
          left = idx
          right = idx + 1
          break
        elsif val > bank_ints[left]
          left = idx
          right = idx + 1
        end
      end
      idx = right + 1
      while idx <= last do
        next_val = bank_ints[idx]
        if next_val > bank_ints[right]
          right = idx
        end
        idx += 1
      end
      [bank_ints[left], bank_ints[right]].join.to_i
    end.sum
    result
    # 16816 - too low
  end

  def self.solve_two(input)
    # Parse input as needed
    lines = input.strip.split("\n")

    # Your solution logic here
    result = lines.length

    result
  end
end
