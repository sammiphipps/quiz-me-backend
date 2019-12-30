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

opentdbApis = ["https://opentdb.com/api.php?amount=10&category=9&type=multiple", "https://opentdb.com/api.php?amount=10&category=9&type=boolean", "https://opentdb.com/api.php?amount=10&category=18&type=multiple", "https://opentdb.com/api.php?amount=10&category=18&type=boolean", "https://opentdb.com/api.php?amount=10&category=19&type=multiple", "https://opentdb.com/api.php?amount=10&category=19&type=boolean", "https://opentdb.com/api.php?amount=10&category=22&type=multiple", "https://opentdb.com/api.php?amount=10&category=22&type=boolean"]
opentdbApis.map do |opentdb|
    request = RestClient.get(opentdb)
    response = JSON.parse(request)
    data = response["results"]

    data.map do |question|

        if Category.find_by(name: question["category"]) 
            category = Category.find_by(name: question["category"])
        else 
            category = Category.create(name: question["category"])
        end 

        database_question = Question.create(
            answer_type: question["type"],
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
end 