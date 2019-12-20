class Question < ApplicationRecord
  belongs_to :category
  has_one :correct_answer
end
