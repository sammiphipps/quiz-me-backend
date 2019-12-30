class QuestionsController < ApplicationController
    def index 
        questions = Question.all
        render json: questions, include: [:correct_answer => {only: [:id, :message]}, :incorrect_answers => {only: [:id, :message]}], except: [:created_at, :updated_at]
    end 

    def show 
        question = Question.find(params[:id])
        render json: question, include: [:correct_answer => {only: [:id, :message]}, :incorrect_answers => {only: [:id, :message]}], except: [:created_at, :updated_at]
    end 

    def create 
        question = Question.create(
            answer_type: params[:answer_type],
            difficulty: params[:difficulty],
            message: params[:message],
            category_id: params[:category_id]
        )
        render json: question, except: [:created_at, :updated_at]
    end 

    def update 
        question = Question.find(params[:id])
        question.update(
            answer_type: params[:answer_type],
            difficulty: params[:difficulty],
            message: params[:message],
            category_id: params[:category_id]
        )
        render json: question, include: [:correct_answer => {only: [:id, :message]}, :incorrect_answers => {only: [:id, :message]}], except: [:created_at, :updated_at]
    end 

    def destroy 
        question = Question.find(params[:id])
        question.destroy
        render json: {message: "The question has been destroyed.", status: 204}
    end 
end
