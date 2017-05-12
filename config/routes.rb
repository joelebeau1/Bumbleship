Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "games#index"
  get "/games/:id" => "games#show", as: :game_show
  get "/games/:game_id/boards/:id/setup" => "boards#setup"
  get "/games/:game_id/boards/:id/play" => "boards#play", as: :game_board_play
  patch "/games/:game_id/boards/:id" => "boards#update"
  patch "/games/:game_id/boards/:id/fire" => "boards#fire", as: :game_board_fire
end
