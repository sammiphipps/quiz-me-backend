class QuestionsController < ApplicationController
    def index 
        questions = Question.all.sort_by {|question| question.created_at }.reverse
        render json: questions, 
            include: [
                :correct_answer => {only: [:id, :message]}, 
                :incorrect_answers => {only: [:id, :message]}, 
                :quizzes => {only: [:id, :name]}, 
                :tests => {only: [:id, :name, :description, :teacher_created]},
                :category => {only: [:id, :name]}
            ],
            except: [:category_id]
    end 

    def show 
        question = Question.find(params[:id])
        render json: question, 
            include: [
                :correct_answer => {only: [:id, :message]}, 
                :incorrect_answers => {only: [:id, :message]}, 
                :quizzes => {only: [:id, :name]}, 
                :tests => {only: [:id, :name, :description, :teacher_created]},
                :category => {only: [:id, :name]}
            ], 
            except: [:category_id]
    end 

    def get_study_cards 
        questions = Question.all
        study_cards = questions.select { |question| question.study_card == true }
        study_cards_sorted = study_cards.sort_by {|question| question.created_at }.reverse
        render json: study_cards_sorted, 
            include: [
                :correct_answer => {only: [:id, :message]}, 
                :incorrect_answers => {only: [:id, :message]},
                :category => {only: [:id, :name]}
            ], 
            except: [:category_id]
    end 

    def create 
        question = Question.create(question_params)
        render json: question
    end 

    def create_question_answers
        question = Question.create(question_params)
        correct_answer = CorrectAnswer.create(correct_answer_params.merge(:question_id => question.id))
        params[:incorrect_answers].map do |incorrect_answer|
            IncorrectAnswer.create(
                message: incorrect_answer[:message],
                question_id: question.id
            )
        end
        render json: question, 
            include: [
                :correct_answer => {only: [:id, :message]}, 
                :incorrect_answers => {only: [:id, :message]}
            ]
    end 

    def update 
        question = Question.find(params[:id])
        question.update(question_params)
        render json: question, 
            include: [
                :correct_answer => {only: [:id, :message]}, 
                :incorrect_answers => {only: [:id, :message]},
                :category => {only: [:id, :name]}
            ], 
            except: [:category_id]
    end 

    def destroy 
        question = Question.find(params[:id])
        question.destroy
        render json: {message: "The question has been destroyed.", status: 204}
    end 

    private

    def question_params
        params.require(:question).permit(:answer_type, :message, :category_id)
    end 

    def correct_answer_params
        params.require(:correct_answer).permit(:message)
    end 
end
