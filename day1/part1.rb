require_relative './input.rb'

class Trebuchet
  NUMBERS = {
    'one' => 1,
    'two' => 2,
    'three' => 3,
    'four' => 4,
    'five' => 5,
    'six' => 6,
    'seven' => 7,
    'eight' => 8,
    'nine' => 9
  }

  def initialize(input)
    @input = input
  end

  def part1
    @input.map { |line| calibration_value(digit_positions(line)) }.sum
  end

  def part2
    @input.map { |line| calibration_value(letter_numbers_positions(line).merge(digit_positions(line))) }.sum
  end

  private

  def letter_numbers_positions(line)
    positions = {}
    NUMBERS.keys.each do |str_number|
      indexes_for(str_number, line).each do |index|
        positions[index] = str_number
      end
    end
    positions
  end

  def digit_positions(line)
    positions = {}
    line.chars.each_with_index do |c, index|
      n_key = NUMBERS.key(c.to_i)
      positions[index] = n_key if n_key
    end
    positions
  end

  def indexes_for(substring, string)
    string.enum_for(:scan,/#{substring}/).map { Regexp.last_match.begin(0) }
  end

  def calibration_value(positions)
    new_chars = positions.sort_by { |k, v| k }.map(&:last).map { |l| NUMBERS[l] }.join
    (new_chars.chars.first + new_chars.chars.last).to_i
  end
end

treabuchet = Trebuchet.new(Input::INPUT)
puts 'PART 1 --> ' + "#{treabuchet.part1}"
puts 'PART 2 --> ' + "#{treabuchet.part2}"

