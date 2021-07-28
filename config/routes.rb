Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :categories, except: [:new, :edit]
  resources :questions, except: [:new, :edit]
  resources :correct_answers, except: [:new, :edit]
  resources :incorrect_answers, except: [:new, :edit]
  resources :quiz_questions, except: [:update, :new, :edit]
  resources :quizzes, except: [:create, :destory, :new, :edit]
  resources :test_questions, except: [:create, :update, :destory, :new, :edit]
  resources :tests, except: [:create, :update, :destory, :new, :edit]
  post "question-with-answers", to: "questions#create_question_answers"
  get "study_cards", to: "questions#get_study_cards"
  delete "quiz_questions", to: "quiz_questions#destroy_using_quiz_question_ids"
end
