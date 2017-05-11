Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "games#show"

  resources :games, only: [:show, :index]

  get 'games/:game_id/boards/:id/play', to: 'boards#play'
end
