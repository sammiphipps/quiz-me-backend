class Question < ApplicationRecord
  belongs_to :category
  has_one :correct_answer, dependent: :destroy
  has_many :incorrect_answers, dependent: :destroy
  has_many :quizzes
  has_many :tests
end
