class Solver
  def self.solve_one(input)
    invalid_ids = []
    parse_ranges(input).each do |start, end_val|
      # Impossible to split any member of a range that all have an odd length
      if start.to_s.length % 2 == 1 && start.to_s.length == end_val.to_s.length
        next
      end
      (start..end_val).each do |id|
        str = id.to_s
        len = str.length
        next if len.odd?
        half = len / 2
        invalid_ids << id if str[0, half] == str[half, half]
      end
    end
    invalid_ids.sum
  end

  def self.solve_two(input)
    invalid_ids = Set.new
    parse_ranges(input).each do |start, end_val|
      (start..end_val).each do |id|
        next if invalid_ids.include?(id)
        str = id.to_s
        len = str.length
        half = len / 2
        (1..half).select { |n| len % n == 0 }.each do |segment_len|
          segments = str.chars.each_slice(segment_len).map(&:join)
          if segments.uniq.length == 1
            invalid_ids << id
            break # No need to check further divisors for this ID
          end
        end
      end
    end
    invalid_ids.sum
  end

  def self.parse_ranges(input)
    input.strip.split(",").map { |r| r.split('-').map(&:to_i) }
  end
end
