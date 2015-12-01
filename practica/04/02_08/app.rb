require_relative "Game"
Bundler.require

set :views, Proc.new { File.join(root, "") }

set :current_games, []

set :finished_games, []

set :ready_games, [
    Game.new("paralelepipedo", 5, 7, 11),
    Game.new("banana", 2, 4),
    Game.new("cortina", 2),
    Game.new("estufa", 2),
    Game.new("laconchadetumadreallboys", 0, 18, 19),
    Game.new("cocina", 0, 2),
    Game.new("mesa", 1)
  ]

get "/" do
  taken_key = settings.ready_games.index(settings.ready_games.sample)
  taken_game = settings.ready_games[taken_key]
  taken_game.start
  settings.ready_games.delete(taken_key)
  settings.current_games[taken_key] = taken_game
  redirect to("/partida/#{taken_game.id}")
end

get "/partida/:id" do |id|
  game = settings.current_games[id.to_i] || settings.finished_games[id.to_i]
  state = game.current_state
  if state["finished"] && state["has_won"]
    view = %(
      Juego terminado <br>
      Resultado: Ganador!! <br>
      Palabra: <%= actual_word %> <br>
      Cantidad de intentos fallidos: <%= tries %> <br>
    )
    erb view, locals: {
      actual_word: state["actual_word"],
      tries: state["tries"]
    }
  elsif state["finished"] && !state["has_won"]
    view = %(
      Juego terminado <br>
      Resultado: Perdedor!! <br>
      Palabra: <%= actual_word %> <br>
      Palabra obtenida: <%= current_word %> <br>
      Cantidad de intentos fallidos: <%= tries %> <br>
    )
    erb view, locals: {
      actual_word: state["actual_word"],
      current_word: state["current_word"],
      tries: state["tries"]
    }
  else
    view = %(
      Palabra: <%= current_word %> <br>
      Cantidad de intentos fallidos: <%= tries %> <br>
      Intentos restantes: <%= remaining_tries %> <br>
    )
    erb view, locals: {
      current_word: state["current_word"],
      tries: state["tries"],
      remaining_tries: state["remaining_tries"]
    }
  end
end

get "/partida/:id/:letter" do |id, letter|
  game = settings.current_games[id.to_i]
  game.try_letter(letter)
  if game.finished
    settings.finished_games[game.id.to_i] = game
    settings.current_games.delete(game.id.to_i)
  end
  redirect to("/partida/#{id}")
end
