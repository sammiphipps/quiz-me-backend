class Question < ApplicationRecord
  belongs_to :category
  has_one :correct_answer, dependent: :destroy
  has_many :incorrect_answers, dependent: :destroy
  has_many :quiz_questions
  has_many :quizzes, through: :quiz_questions
  has_many :test_questions
  has_many :tests, through: :test_questions
end
