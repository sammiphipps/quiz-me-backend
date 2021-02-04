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
Quiz.destroy_all
QuizQuestion.destroy_all
Test.destroy_all
TestQuestion.destroy_all


test_sample = Test.create(
    name: 'Exam 1',
    description: 'Test Sample',
    teacher_created: nil
)

quiz_sample = Quiz.create(
    name: 'Quiz 1'
)

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

        #Determine if question will be included in Test Sample 
        test_sample_determination = rand(0..1)

        #Determine if question will be included in Quiz Sample 
        quiz_sample_determination = rand(0..1)

        #Determine if question will be a study_card
        study_card_determination = rand(0..1)

        if study_card_determination == 1 
            study_card_boolean = true 
        else 
            study_card_boolean = false 
        end 

        database_question = Question.create(
            answer_type: question["type"],
            message: question["question"].gsub('&quot;', '"').gsub('&#039;', "'"),
            category: category,
            study_card: study_card_boolean
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

        #Question should be included in test sample if random number generated 1 
        if test_sample_determination == 1
            TestQuestion.create(
                test: test_sample,
                question: database_question
            )
        end 

        #Question should be included in quiz sample if random number generated 1
        if quiz_sample_determination == 1
            QuizQuestion.create(
                quiz: quiz_sample,
                question: database_question
            )
        end 
    end 
end 