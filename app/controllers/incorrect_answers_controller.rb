class IncorrectAnswersController < ApplicationController
    def index 
        incorrect_answers = IncorrectAnswer.all
        render json: incorrect_answers, include: [:question => {only: [:id, :message]}], except: [:created_at, :updated_at]
    end 

    def show 
        incorrect_answer = IncorrectAnswer.find(params[:id])
        render json: incorrect_answer, include: [:question => {only: [:id, :message]}], except: [:created_at, :updated_at]
    end 

    def create 
        incorrect_answer = IncorrectAnswer.create(
            message: params[:message],
            question_id: params[:question_id]
        )
        render json: incorrect_answer, include: [:question => {only: [:id, :message]}], except: [:created_at, :updated_at]
    end 

    def update 
        incorrect_answer = IncorrectAnswer.find(params[:id])
        incorrect_answer.update(
            message: params[:message],
            question_id: params[:question_id]
        )
        render json: incorrect_answer, include: [:question => {only: [:id, :message]}], except: [:created_at, :updated_at]
    end 

    def destroy 
        incorrect_answer = IncorrectAnswer.find(params[:id])
        incorrect_answer.destroy
        render json: {message:"This answer has been destroyed." , status: 204}
    end 
end
