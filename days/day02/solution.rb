class Solver
  def self.solve_one(input)
    # Parse input as needed
    ranges = input.strip.split(",")
    doubles = []
    ranges.each do |this_range_str|
      start, end_val = this_range_str.split('-').map(&:to_i)
      if start.to_s.length % 2 == 1 && start.to_s.length == end_val.to_s.length
        next
      end
      (start..end_val).each do |id|
        this_len = id.to_s.length
        if this_len % 2 != 0
          next
        end
        front = id.to_s[0, this_len / 2]
        back = id.to_s[this_len/2,this_len]
        if front == back
          doubles.push id
        end
      end
    end
    doubles.map(&:to_i).sum
  end

  def self.solve_two(input)
    # Parse input as needed
    lines = input.strip.split("\n")

    # Your solution logic here
    result = lines.length

    result
  end
end
