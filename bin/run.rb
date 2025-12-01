#!/usr/bin/env ruby
# frozen_string_literal: true

require 'time'
require_relative '../lib/utils'

def main
  unless ARGV.length == 2
    puts "Usage: ruby bin/run.rb <day> <part>"
    puts "Example: ruby bin/run.rb 01 1"
    exit 1
  end

  day = ARGV[0].to_i
  part = ARGV[1].to_i

  unless (1..25).include?(day) && [1, 2].include?(part)
    puts "Invalid day (1-25) or part (1-2)"
    exit 1
  end

  # Load the solution file
  day_dir = format("days/day%02d", day)
  part_file = "#{day_dir}/part#{part}.rb"

  unless File.exist?(part_file)
    puts "Solution file not found: #{part_file}"
    exit 1
  end

  require_relative "../#{part_file}"

  # Load input
  input = Utils.read_input(day, part)

  # Get the solution class
  solution_class = Object.const_get("Part#{part}")

  # Time and run the solution
  start_time = Time.now
  result = solution_class.solve(input)
  end_time = Time.now

  elapsed_ms = ((end_time - start_time) * 1000).round(2)

  puts "Day #{day}, Part #{part}:"
  puts "Result: #{result}"
  puts "Time: #{elapsed_ms}ms"
rescue => e
  puts "Error: #{e.message}"
  exit 1
end

main if __FILE__ == $PROGRAM_NAME