# Advent of Code 2025

A Ruby project for solving Advent of Code 2025 puzzles.

## Project Structure

```
├── lib/
│   └── utils.rb          # Shared utilities for parsing and common algorithms
├── days/
│   ├── day00/            # Template directory (copy this for new days)
│   │   ├── README.md     # Puzzle description and examples
│   │   ├── part1.rb      # Solution for part 1
│   │   ├── part2.rb      # Solution for part 2
│   │   ├── input1.txt    # Puzzle input for part 1
│   │   ├── input2.txt    # Puzzle input for part 2
│   │   └── test.rb       # Unit tests with sample inputs
│   └── day01/            # Day 1 solutions
├── test/
│   └── test_utils.rb     # Tests for utility functions
├── bin/
│   └── run.rb            # Runner script for executing solutions
└── README.md
```

## Getting Started

1. **Create a new day**: Run `ruby bin/create_day.rb <day_number>` (e.g., `ruby bin/create_day.rb 1`)

2. **Update README**: Edit the `README.md` in the new day directory with the puzzle description and examples

3. **Add puzzle input**: Replace the content in `input1.txt` and `input2.txt` with your actual puzzle input

4. **Implement solutions**: Edit `part1.rb` and `part2.rb` to solve the puzzles. Each file should contain a class with a `solve(input)` method

5. **Write tests**: Update `test.rb` with sample inputs and expected outputs for testing

6. **Run tests**: Execute `ruby days/day01/test.rb` to verify your solutions work with sample data

7. **Run with puzzle input**: Use `ruby bin/run.rb 01 1` to get the answer for submission

## Usage

### Running Solutions

```bash
# Run day 1, part 1
ruby bin/run.rb 01 1

# Run day 1, part 2
ruby bin/run.rb 01 2

# Run day 25, part 2
ruby bin/run.rb 25 2
```

### Creating New Days

```bash
# Create a new day directory with boilerplate
ruby bin/create_day.rb 2

# This creates days/day02/ with all necessary files
```

### Running Tests

```bash
# Test utilities
ruby test/test_utils.rb

# Test a specific day (e.g., day 1)
ruby days/day01/test.rb
```

## Solution Template

Each part file should follow this structure:

```ruby
class Part1  # or Part2
  def self.solve(input)
    # Parse input as needed
    lines = input.strip.split("\n")

    # Your solution logic here
    result = lines.length

    result
  end
end
```

## Utilities

The `lib/utils.rb` file provides common helper functions:

- `parse_lines(input)` - Split input into lines
- `parse_integers(input)` - Parse input as integers
- `parse_grid(input)` - Parse input as a 2D grid
- `manhattan_distance(x1, y1, x2, y2)` - Calculate Manhattan distance
- `grid_neighbors(grid, row, col, include_diagonal: false)` - Get neighboring cells
- And more...

## Testing

This project uses Minitest for unit testing. Tests should include:

- Sample inputs with known expected outputs
- Edge cases
- Validation of parsing logic

Example test:

```ruby
def test_part1_sample
  sample_input = "sample\ninput\nhere"
  expected = 42
  assert_equal expected, Part1.solve(sample_input)
end
```

## Requirements

- Ruby (comes with Minitest built-in)
- No external dependencies required