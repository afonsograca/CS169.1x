class RockPaperScissors

  # Exceptions this class can raise:
  class NoSuchStrategyError < StandardError ; end

  def self.winner(player1, player2)
    raise NoSuchStrategyError.new("Strategy must be one of R,P,S") unless (['R','P','S'].include?(player2[1]) && ['R','P','S'].include?(player1[1]))
  
    if (player1[1] == 'R' && player2[1] == 'P') || (player1[1] == 'P' && player2[1] == 'S') || (player1[1] == 'S' && player2[1] == 'R')
      player2
    else
      player1
    end
  end

  def self.tournament_winner(tournament)
    if tournament[0][0].is_a?(String)
      winner(tournament[0],tournament[1])
    else
      winner(tournament_winner(tournament[0]),tournament_winner(tournament[1]))
    end
  end

end