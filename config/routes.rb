Rails.application.routes.draw do
  get 'games/new', as: 'new'
  get 'games/score', as: 'score'

  post 'games/score', to: 'games#score'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
