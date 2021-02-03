Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "application#index"
  resources :categories, except: [:new, :edit]
  resources :questions, except: [:new, :edit]
  resources :correct_answers, except: [:new, :edit]
  resources :incorrect_answers, except: [:new, :edit]
  resources :quiz_questions, except: [:new, :edit]
  resources :quizzes, except: [:new, :edit]
  resources :test_questions, except: [:new, :edit]
  resources :tests, except: [:new, :edit]
  post "question-with-answers", to: "questions#create_question_answers"
end
