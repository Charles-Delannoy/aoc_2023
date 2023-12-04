class ScratchCards
  GAME_REGEX = /Card( )+(?<game_number>\d+):(?<game_cards>.*)\|(?<my_cards>.*)/

  def initialize(input_path)
    @games = games(input_path)
  end

  def part1
    @games.reduce(0) do |score, (game, range)|
      score += range.reduce(0) { |game_score| game_score.zero? ? game_score = 1 : game_score *= 2 }
    end
  end

  def part2
    my_cards = @games.keys
    @games.each { |game, range| my_cards.count(game).times { my_cards.push(*range) } }
    my_cards.size
  end

  private

  def games(input_path)
    games = {}

    File.foreach('./day4/input.txt') do |line|
      game = line.match(GAME_REGEX)
      game_number = game[:game_number].to_i
      n_winning_cards = cards(game[:game_cards]).intersection(cards(game[:my_cards])).size
      games[game_number] = ((game_number + 1)..(game_number + n_winning_cards)).to_a
    end

    games
  end

  def cards(cards_string)
    cards_string.scan(/\d+/).map(&:to_i)
  end
end

scratch_cards = ScratchCards.new('./day4/input.txt')
puts "PART 1 => #{scratch_cards.part1}"
puts "PART 2 => #{scratch_cards.part2}"
