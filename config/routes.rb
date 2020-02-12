Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :categories, except: [:new, :edit]
  resources :questions, except: [:new, :edit]
  resources :correct_answers, except: [:new, :edit]
  resources :incorrect_answers, except: [:new, :edit]
  post "question-with-answers", to: "questions#create_question_answers"
end
