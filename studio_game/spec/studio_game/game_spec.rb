require 'studio_game/game'

module StudioGame
  describe Game do
    
    before do
      @game = Game.new("Knuckleheads")
      @initial_health = 100
      @player = Player.new("moe", @initial_health)
      @game.add_player(@player)
    end

    context "a high number" do 
      it "w00ts a player if a high number is called" do 
        allow_any_instance_of(Die).to receive(:roll).and_return(5)
        @game.play(2)
        expect(@player.health).to eq(@initial_health + (15 * 2))
      end

      it "skips a player if a medium number is called" do 
        allow_any_instance_of(Die).to receive(:roll).and_return(3)
        @game.play(2)
        expect(@player.health).to eq(@initial_health)
      end

      it "blams a player if a low number is called" do 
        allow_any_instance_of(Die).to receive(:roll).and_return(1)
        @game.play(2)
        expect(@player.health).to eq(@initial_health - (10 * 2))
      end
    end

    it "assigns a treasure for points during a player's turn" do
      game = Game.new("Knuckleheads")
      player = Player.new("moe")

      game.add_player(player)

      game.play(1)

      player.points.should_not be_zero

      # or use alternate expectation syntax:
      # expect(player.points).not_to be_zero
    end

  end
end