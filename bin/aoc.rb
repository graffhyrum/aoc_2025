#!/usr/bin/env ruby

require 'optparse'
require 'pathname'

class AOCNavigator
  def initialize
    @current_day = nil
    @days_dir = Pathname.new('days')
  end

  def run
    if ARGV.empty?
      interactive_mode
    else
      command_line_mode
    end
  end

  private

  def interactive_mode
    puts "🎄 Advent of Code 2025 Navigator 🎄"
    puts "=" * 40

    loop do
      display_menu
      choice = get_user_choice

      case choice
      when '1'
        list_days
      when '2'
        select_day
      when '3'
        run_tests if @current_day
      when '4'
        run_part(1) if @current_day
      when '5'
        run_part(2) if @current_day
      when '6'
        create_new_day
      when 'q', 'Q'
        puts "Goodbye! 🎅"
        break
      else
        puts "❌ Invalid choice. Please try again."
      end

      puts "\n" unless choice == 'q' || choice == 'Q'
    end
  end

  def command_line_mode
    options = {}
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: ruby #{$0} [options] [command]"

      opts.on("-d", "--day DAY", "Specify day (01-25)") do |day|
        options[:day] = day.rjust(2, '0')
      end

      opts.on("-p", "--part PART", "Specify part (1 or 2)") do |part|
        options[:part] = part.to_i
      end

      opts.on("-t", "--test", "Run tests for the day") do
        options[:test] = true
      end

      opts.on("-l", "--list", "List all available days") do
        options[:list] = true
      end

      opts.on("-c", "--create DAY", "Create new day directory") do |day|
        options[:create] = day.rjust(2, '0')
      end

      opts.on("-h", "--help", "Show this help") do
        puts opts
        exit
      end
    end

    parser.parse!

    if options[:list]
      list_days
    elsif options[:create]
      create_day(options[:create])
    elsif options[:day]
      @current_day = options[:day]
      if options[:test]
        run_tests
      elsif options[:part]
        run_part(options[:part])
      else
        puts "❌ Please specify --test or --part"
      end
    else
      puts "❌ Please specify a day with -d or use -l to list days"
      puts parser
    end
  end

  def display_menu
    puts "\n📅 Current Day: #{@current_day || 'None selected'}"
    puts "\nChoose an option:"
    puts "1. 📋 List all days"
    puts "2. 🎯 Select a day"
    puts "3. 🧪 Run tests#{@current_day ? " (Day #{@current_day})" : ' (Select day first)'}"
    puts "4. 🚀 Run Part 1#{@current_day ? " (Day #{@current_day})" : ' (Select day first)'}"
    puts "5. 🚀 Run Part 2#{@current_day ? " (Day #{@current_day})" : ' (Select day first)'}"
    puts "6. ➕ Create new day"
    puts "Q. 👋 Quit"
    print "\nYour choice: "
  end

  def get_user_choice
    gets.chomp.strip
  end

  def list_days
    if @days_dir.exist?
      day_dirs = @days_dir.children.select(&:directory?).map { |d| d.basename.to_s }.sort
      if day_dirs.empty?
        puts "📭 No days found. Create your first day with option 6!"
      else
        puts "📋 Available days:"
        day_dirs.each do |day|
          status = day == @current_day ? " ← Current" : ""
          puts "  #{day}#{status}"
        end
      end
    else
      puts "📭 Days directory not found. Create your first day with option 6!"
    end
  end

  def select_day
    list_days
    print "\nEnter day number (01-25): "
    day_input = gets.chomp.strip

    if valid_day?(day_input)
      @current_day = day_input.rjust(2, '0')
      puts "✅ Selected Day #{@current_day}"
    else
      puts "❌ Invalid day format. Use 01-25."
    end
  end

  def run_tests
    test_file = @days_dir / "day#{@current_day}" / 'test.rb'
    if test_file.exist?
      puts "🧪 Running tests for Day #{@current_day}..."
      system("ruby #{test_file}")
    else
      puts "❌ Test file not found: #{test_file}"
    end
  end

  def run_part(part)
    solution_file = @days_dir / "day#{@current_day}" / "part#{part}.rb"
    input_file = @days_dir / "day#{@current_day}" / "input#{part}.txt"

    unless solution_file.exist?
      puts "❌ Solution file not found: #{solution_file}"
      return
    end

    unless input_file.exist?
      puts "❌ Input file not found: #{input_file}"
      return
    end

    puts "🚀 Running Day #{@current_day}, Part #{part}..."

    begin
      # Load the solution class
      load solution_file.to_s

      # Read input
      input = File.read(input_file)

      # Run the solution
      class_name = "Part#{part}"
      if Object.const_defined?(class_name)
        result = Object.const_get(class_name).solve(input)

        # Print result on its own line for easy copy/paste
        puts result

        # Save result to output file
        output_file = @days_dir / "day#{@current_day}" / "output#{part}.txt"
        File.write(output_file, result.to_s)
        puts "💾 Result saved to #{output_file}"
      else
        puts "❌ Class #{class_name} not found in #{solution_file}"
      end
    rescue => e
      puts "❌ Error running solution: #{e.message}"
      puts e.backtrace.first if ENV['DEBUG']
    end
  end

  def create_new_day
    print "Enter day number (1-25): "
    day_input = gets.chomp.strip

    unless valid_day?(day_input)
      puts "❌ Invalid day format. Use 1-25."
      return
    end

    day = day_input.rjust(2, '0')
    create_day(day)
  end

  def create_day(day)
    day_dir = @days_dir / "day#{day}"

    if day_dir.exist?
      puts "❌ Day #{day} already exists!"
      return
    end

    puts "📁 Creating Day #{day}..."

    # Create directory structure
    day_dir.mkpath

    # Create template files
    create_template_files(day_dir, day)

    puts "✅ Created Day #{day} with template files!"
    @current_day = day
  end

  def create_template_files(day_dir, day)
    # part1.rb
    File.write(day_dir / 'part1.rb', <<~RUBY)
      class Part1
        def self.solve(input)
          # Parse input as needed
          lines = input.strip.split("\\n")

          # Your solution logic here
          result = lines.length

          result
        end
      end
    RUBY

    # part2.rb
    File.write(day_dir / 'part2.rb', <<~RUBY)
      class Part2
        def self.solve(input)
          # Parse input as needed
          lines = input.strip.split("\\n")

          # Your solution logic here
          result = lines.length

          result
        end
      end
    RUBY

    # test.rb
    File.write(day_dir / 'test.rb', <<~RUBY)
      require 'minitest/autorun'
      require_relative 'part1'
      require_relative 'part2'

      class TestDay#{day} < Minitest::Test
        def test_part1_sample
          sample_input = ""
          expected = 0
          assert_equal expected, Part1.solve(sample_input)
        end

        def test_part2_sample
          sample_input = ""
          expected = 0
          assert_equal expected, Part2.solve(sample_input)
        end
      end
    RUBY

    # input1.txt and input2.txt (empty)
    File.write(day_dir / 'input1.txt', '')
    File.write(day_dir / 'input2.txt', '')

    # output1.txt and output2.txt (empty, will be populated when solutions run)
    File.write(day_dir / 'output1.txt', '')
    File.write(day_dir / 'output2.txt', '')

    # README.md
    File.write(day_dir / 'README.md', <<~MARKDOWN)
      # Day #{day.to_i}: [Puzzle Title]

      ## Part 1

      [Puzzle description here]

      ### Examples

      ```
      Input:
      [sample input]

      Output: [expected output]
      ```

      ## Part 2

      [Part 2 description]

      ### Examples

      ```
      Input:
      [sample input]

      Output: [expected output]
      ```
    MARKDOWN
  end

  def valid_day?(day_str)
    day_str.match?(/^\d{1,2}$/) && (1..25).include?(day_str.to_i)
  end
end

# Run the navigator
if __FILE__ == $0
  AOCNavigator.new.run
end