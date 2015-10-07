require_relative 'player'
require_relative 'die'
require_relative 'game_turn'
require_relative 'treasure_trove'

class Game
  attr_reader :title

  def initialize(title)
    @title = title
    @players = []
  end

  def load_players(from_file)
    File.readlines(from_file).each do |line|
      add_player(Player.from_csv(line))
    end
  end

  def save_high_scores(to_file="high_scores.txt")
    File.open(to_file, "w") do |file|
      file.puts "#{@title} High Scores:"
      @players.sort.each do |player|
        file.puts high_score_entry(player)
      end
    end
  end

  def add_player(player)
    @players << player
  end
  
  def play(rounds)
    puts "There are #{@players.size} players in #{@title}:"
    @players.each do |player|
      puts player
    end
    1.upto(rounds) do |round|
      puts "\nRound #{round}:"
      @players.each do |player|
        GameTurn.take_turn(player)
      end
    end

    treasures = TreasureTrove::TREASURES

    puts "\nThere are #{treasures.size} treasures to be found."
    treasures.each do |treasure|
      puts "A #{treasure.name} is worth #{treasure.points} points."
    end
  end

  def print_stats
    strong, wimpy = @players.partition { |player| player.strong? }
    
    puts "\n#{title} Statistics:"
    puts "\n#{strong.count} strong players:"
    strong.each do |strong_player|
      puts "#{strong_player.name} (#{strong_player.score})"
    end

    puts "\n#{wimpy.count} wimpy players:"
    wimpy.each do |wimpy_player| 
      puts "#{wimpy_player.name} (#{wimpy_player.score})"
    end

    @players.sort.each do |player|
      puts "\n#{player.name}'s point totals:"
      player.each_found_treasure do |treasure|
        puts "#{treasure.points} total #{treasure.name} points"
      end
      puts "#{player.points} grand total points"
    end

    puts "\n#{@title} High Scores:"
    @players.sort.each do |player|
      puts high_score_entry(player)
    end
  end

  def high_score_entry(player)
    formatted_name = player.name.ljust(20, '.')
    "#{formatted_name} #{player.score}"
  end

end
