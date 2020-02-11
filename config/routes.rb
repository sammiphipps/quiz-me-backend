Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :categories, except: [:new, :edit]
  resources :questions, only: [:index, :show]
  resources :correct_answers, only: [:index, :show]
  resources :incorrect_answers, only: [:index, :show]
end
