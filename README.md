# Advent of Code 2025

🎄 A Ruby project for solving Advent of Code 2025 puzzles with an interactive CLI navigator!

**Quick Start:** Run `ruby bin/aoc.rb` for the interactive menu, or use `ruby bin/aoc.rb --help` for command-line options.

## Project Structure

```
├── lib/
│   └── utils.rb          # Shared utilities for parsing and common algorithms
├── days/
│   ├── day00/            # Template directory (copy this for new days)
│   │   ├── README.md     # Puzzle description and examples
│   │   ├── solution.rb   # Solution class with solve_one and solve_two methods
│   │   ├── input1.txt    # Puzzle input for part 1
│   │   ├── input2.txt    # Puzzle input for part 2
│   │   ├── output1.txt   # Solution output for part 1 (auto-generated)
│   │   ├── output2.txt   # Solution output for part 2 (auto-generated)
│   │   └── test.rb       # Unit tests with sample inputs
│   └── day01/            # Day 1 solutions
├── test/
│   └── test_utils.rb     # Tests for utility functions
├── bin/
│   ├── aoc.rb            # Interactive CLI for navigation, testing, and execution
│   ├── run.rb            # Legacy runner script for executing solutions
│   └── create_day.rb     # Legacy script for creating new days
└── README.md
```

## Getting Started

1. **Create a new day**: Run `ruby bin/aoc.rb --create <day_number>` (e.g., `ruby bin/aoc.rb --create 1`)

2. **Update README**: Edit the `README.md` in the new day directory with the puzzle description and examples

3. **Add puzzle input**: Replace the content in `input1.txt` and `input2.txt` with your actual puzzle input

4. **Implement solutions**: Edit `solution.rb` to solve the puzzles. The file should contain a class with `solve_one(input)` and `solve_two(input)` methods

5. **Write tests**: Update `test.rb` with sample inputs and expected outputs for testing

6. **Run tests**: Execute `ruby bin/aoc.rb --day 1 --test` to verify your solutions work with sample data

7. **Run with puzzle input**: Use `ruby bin/aoc.rb --day 1 --part 1` to get the answer for submission

### Quick Start with Interactive CLI

For the easiest experience, use the interactive CLI:

```bash
ruby bin/aoc.rb
```

This will guide you through creating days, running tests, and executing solutions with a menu-driven interface.

## Usage

### Interactive CLI

🎄 **Recommended for beginners!** Use the interactive Advent of Code navigator for easy day navigation, testing, and solution execution:

```bash
ruby bin/aoc.rb
```

This provides a user-friendly menu-driven interface featuring:
- 📋 **List all available days** - See what days you've created
- 🎯 **Select and navigate between days** - Switch context easily
- 🧪 **Run tests for the current day** - Verify your solutions
- 🚀 **Execute Part 1 or Part 2 solutions** - Get your answers (results auto-saved for easy reference)
- ➕ **Create new day directories** - Set up new puzzles with templates
- 🎅 **Festive interface** - Enjoy the holiday spirit!

The interactive mode is perfect for:
- Learning Advent of Code
- Quick navigation between days
- Avoiding command-line syntax
- Getting started with the project

### Command Line Usage

```bash
# List all available days
ruby bin/aoc.rb --list

# Run tests for day 1
ruby bin/aoc.rb --day 1 --test

# Run day 1, part 1 solution
ruby bin/aoc.rb --day 1 --part 1

# Run day 25, part 2 solution
ruby bin/aoc.rb --day 25 --part 2

# Create a new day directory
ruby bin/aoc.rb --create 2
```

**Note:** When running solutions, results are printed on their own line for easy copy/paste to the Advent of Code website, and automatically saved to `output1.txt`/`output2.txt` files in the day's directory.

### Legacy Commands (still supported)

The original scripts are still available for backward compatibility:

```bash
# Create a new day (legacy)
ruby bin/create_day.rb 2

# Run day 1, part 1 (legacy)
ruby bin/run.rb 01 1

# Run day 1, part 2 (legacy)
ruby bin/run.rb 01 2
```

**Note:** Legacy commands also save results to output files and format them for easy copy/paste.

### CLI Help

Get help with all CLI options:

```bash
ruby bin/aoc.rb --help
```

### Creating New Days

```bash
# Create a new day directory with boilerplate (recommended)
ruby bin/aoc.rb --create 2

# Or use the legacy script
ruby bin/create_day.rb 2

# This creates days/day02/ with all necessary files:
# - solution.rb (solution template with Day02 class)
# - input1.txt and input2.txt (input files)
# - output1.txt and output2.txt (result files, auto-populated when running solutions)
# - test.rb (test template)
# - README.md (documentation template)
```

### Running Tests

```bash
# Test utilities
ruby test/test_utils.rb

# Test a specific day (e.g., day 1)
ruby days/day01/test.rb

# Or use CLI
ruby bin/aoc.rb --day 1 --test
```

## Solution Template

Each day's `solution.rb` file should follow this structure:

```ruby
class Solver
  def self.solve_one(input)
    # Parse input as needed
    lines = input.strip.split("\n")

    # Your solution logic for part 1 here
    result = lines.length

    result
  end

  def self.solve_two(input)
    # Parse input as needed
    lines = input.strip.split("\n")

    # Your solution logic for part 2 here
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
def test_solve_one_sample
  sample_input = "sample\ninput\nhere"
  expected = 42
  assert_equal expected, Solver.solve_one(sample_input)
end

def test_solve_two_sample
  sample_input = "sample\ninput\nhere"
  expected = 42
  assert_equal expected, Solver.solve_two(sample_input)
end
```

## Requirements

- Ruby (comes with Minitest built-in)
- No external dependencies required
- Cross-platform: Works on Windows, macOS, and Linux

## CLI Features

The Advent of Code CLI (`bin/aoc.rb`) provides:

- **Interactive Mode**: Menu-driven interface for easy navigation
- **Command Line Mode**: Direct execution with flags and options
- **Day Management**: Create, list, and navigate between puzzle days
- **Testing**: Run Minitest suites for any day
- **Solution Execution**: Run Part 1/2 solutions with proper input handling
- **Error Handling**: Clear feedback for missing files or invalid inputs
- **Templates**: Auto-generate boilerplate code for new days