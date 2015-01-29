################################################################################
# In a game of rock-paper-scissors, each player chooses to play Rock (R), 
# Paper (P), or Scissors (S). The rules are: Rock breaks Scissors, Scissors cuts 
# Paper, but Paper covers Rock.
# In a round of rock-paper-scissors, each player's name and strategy is encoded 
# as an array of two elements
#      [ ["Armando", "P"], ["Dave", "S"] ] # Dave would win since S > P
################################################################################
class RockPaperScissors

  # Exceptions this class can raise:
  class NoSuchStrategyError < StandardError ; end

  def self.winner(player1, player2)
    s1 = player1[1];
    s2 = player2[1];

    raise NoSuchStrategyError, 
	'Strategy must be one of R,P,S' if !self.is_valid?(s1) || !self.is_valid?(s2)
 
    if s1 != s2 then 
       case s1
          when 'R' then s2 == 'S' ? player1: player2
          when 'S' then s2 == 'P' ? player1: player2
          when 'P' then s2 == 'R' ? player1: player2
	end
    else
       return player1	
    end
  end

  def self.tournament_winner(tournament)
    if tournament[0][0].is_a? String then
	self.winner tournament[0], tournament[1]
    else
	self.tournament_winner([tournament_winner(tournament[0][0]), tournament_winner(tournament[0][1])])
    end
  end

  private

  def self.is_valid?(strategy) 
    strategy =~ /[RPS]/
  end
end

=begin
p RockPaperScissors.winner(['ARMANDO', 'R'], ['DAVE', 'P'])
p RockPaperScissors.winner(['ARMANDO', 'w'], ['DAVE', 'P'])
tourney = [
[
  [ ["Armando", "P"], ["Dave", "S"] ],      
  [ ["Richard", "R"], ["Michael", "S"] ]
],
[
  [ ["Allen", "S"], ["Omer", "P"] ],
  [ ["David E.", "R"], ["Richard X.", "P"] ]
]
]
p RockPaperScissors.tournament_winner(tourney)
=end
