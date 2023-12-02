class CubeGame
  BAG_CONTENT = {
    red: 12,
    green: 13,
    blue: 14
  }

  COLORS = %i[red green blue]

  GAMES_REGEX = /Game (?<game_number>\d+):(?<draws>.*)/
  DRAW_REGEX = /(?<number>\d+) (?<color>\w+)/

  def initialize(input_path)
    @games = max_cubes_needed(input_path)
  end

  def part1
    @games.map do |n_game, draws|
      COLORS.map { |color| draws[color] <= BAG_CONTENT[color] }.all? ? n_game : 0
    end.sum
  end

  def part2
    @games.values.map { |draw| draw.values.inject(:*) }.sum
  end

  private

  def max_cubes_needed(input_path)
    games = {}

    File.foreach(input_path) do |line|
      number_and_draws = line.match(GAMES_REGEX)
      n_game = number_and_draws[:game_number].to_i
      draws = number_and_draws[:draws]
      games[n_game] = { red: 0, green: 0, blue: 0 }

      draws.to_enum(:scan, DRAW_REGEX).map { Regexp.last_match }.each do |color_draw|
        color = color_draw[:color].to_sym
        number = color_draw[:number].to_i
        games[n_game][color] = number if games[n_game][color] < number
      end
    end

    games
  end
end

cubegame = CubeGame.new('./day2/input.txt')
puts 'PART 1 => ' + "#{cubegame.part1}"
puts 'PART 2 => ' + "#{cubegame.part2}"
