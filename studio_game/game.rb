require_relative 'player'
require_relative 'die'
require_relative 'game_turn'

class Game
  attr_reader :title

  def initialize(title)
    @title = title
    @players = []
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
        puts player
      end
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
  end

  def high_scores
    puts "\n#{@title} High Scores:"
    @players.sort.each do |player|
      puts "#{player.name.ljust(30, ".")} #{player.score}"
    end
  end
end
