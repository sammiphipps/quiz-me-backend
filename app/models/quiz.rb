class Quiz < ApplicationRecord
    has_many :quiz_questions
    has_many :questions
end
