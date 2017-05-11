Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "games#index"

  get "/games/:game_id/boards/:id/setup" => "boards#setup"
  get "/games/:game_id/boards/:id/play" => "boards#play"
  patch "/games/:game_id/boards/:id" => "boards#update"
end
