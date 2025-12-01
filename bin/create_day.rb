#!/usr/bin/env ruby
# frozen_string_literal: true

require 'fileutils'

def create_day(day_number)
  day_str = format("%02d", day_number)
  source_dir = "days/day00"
  target_dir = "days/day#{day_str}"

  # Check if source template exists
  unless Dir.exist?(source_dir)
    puts "Error: Template directory #{source_dir} not found!"
    exit 1
  end

  # Check if target directory already exists
  if Dir.exist?(target_dir)
    puts "Error: Directory #{target_dir} already exists!"
    exit 1
  end

  puts "Creating day #{day_number} from template..."

  # Copy the template directory
  FileUtils.cp_r(source_dir, target_dir)

  # Update files in the new directory
  Dir.glob("#{target_dir}/**/*").each do |file|
    next unless File.file?(file)

    content = File.read(file)

    # Replace template placeholders
    updated_content = content
      .gsub("Day 00", "Day #{day_number}")
      .gsub("Day XX", "Day #{day_number}")
      .gsub("day00", "day#{day_str}")
      .gsub("TestDay00", "TestDay#{day_str}")

    # Write back if changed
    if updated_content != content
      File.write(file, updated_content)
      puts "Updated: #{file}"
    end
  end

  puts "✅ Day #{day_number} created successfully!"
  puts "📁 Directory: #{target_dir}"
  puts ""
  puts "Next steps:"
  puts "1. Edit #{target_dir}/README.md with the puzzle description"
  puts "2. Add your puzzle input to #{target_dir}/input1.txt and #{target_dir}/input2.txt"
  puts "3. Implement solutions in #{target_dir}/part1.rb and #{target_dir}/part2.rb"
  puts "4. Update tests in #{target_dir}/test.rb"
  puts "5. Run: ruby #{target_dir}/test.rb"
  puts "6. Run: ruby bin/run.rb #{day_str} 1"
end

def main
  unless ARGV.length == 1
    puts "Usage: ruby bin/create_day.rb <day_number>"
    puts "Example: ruby bin/create_day.rb 1"
    puts "Creates a new day directory from the day00 template"
    exit 1
  end

  day_number = ARGV[0].to_i

  unless (1..25).include?(day_number)
    puts "Error: Day number must be between 1 and 25"
    exit 1
  end

  create_day(day_number)
end

main if __FILE__ == $PROGRAM_NAME