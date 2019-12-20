# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
IncorrectAnswer.destroy_all
CorrectAnswer.destroy_all
Question.destroy_all
Category.destroy_all

opentdb = 'https://opentdb.com/api.php?amount=10'
request = RestClient.get(opentdb)
response = JSON.parse(request)
data = response["results"]

data.map do |question|
    if Category.all.include?(question["category"]) == false 
        category = Category.create(name: question["category"])
    else 
        category = Category.find_by(name: question["category"])
    end 

    database_question = Question.create(
        answer_type: question["type"],
        difficulty: question["difficulty"],
        message: question["question"],
        category: category
    )

    CorrectAnswer.create(
        message: question["correct_answer"],
        question: database_question
    )

    question["incorrect_answers"].map do |incorrect_answer|
        IncorrectAnswer.create(
            message: incorrect_answer,
            question: database_question
        )
    end 
end 