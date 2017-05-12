Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "games#index"
  get "/games/new" => "games#new", as: :new_game
  post "/games" => "games#create", as: :games
  post "/games/join" => "games#join", as: :join_game
  get "/games/:id" => "games#show", as: :game_show
  get "/games/:id/players/new" => "players#new", as: :new_game_player
  post "/games/:id/players" => "players#create", as: :players
  get "/games/:game_id/boards/:id/setup" => "boards#setup", as: :game_board_setup
  get "/games/:game_id/boards/:id/play" => "boards#play", as: :game_board_play
  patch "/games/:game_id/boards/:id" => "boards#update"
  patch "/games/:game_id/boards/:id/fire" => "boards#fire", as: :game_board_fire
end
