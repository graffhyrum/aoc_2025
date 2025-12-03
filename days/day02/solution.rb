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
    ranges = input.strip.split(",")
    dupes = Set.new()
    ranges.each do | this_range_str|
      start, end_val = this_range_str.split('-').map(&:to_i)
      (start..end_val).each do |id|
        if dupes.include?(id)
          next
        end
        id_len = id.to_s.length
        half = (id_len / 2).floor
        (1..half).select {|i| id_len % i == 0} .reverse.each do |n|
          id_segments = id.to_s.chars.each_slice(n).map(&:join)
          if id_segments.uniq.length == 1
            dupes.add? id
          end
        end
      end
    end
    dupes.sum
  end
end
