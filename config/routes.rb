Oodle::Engine.routes.draw do
  resources :answers do
    post :mark_as_completed, on: :member
  end

  resources :items
  resources :questions
  resources :questionnaires
  resources :users

  root "dashboard#index"

  get "dashboard", to: "dashboard#index"
end
