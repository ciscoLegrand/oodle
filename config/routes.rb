Oodle::Engine.routes.draw do
  resources :answers
  resources :items
  resources :questions
  resources :questionnaires

  root "questionnaires#index"
end
