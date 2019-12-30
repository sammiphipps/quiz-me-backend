class CorrectAnswersController < ApplicationController
    def index 
        correct_answers = CorrectAnswer.all
        render json: correct_answers, include: [:question => {only: [:id, :message]}]
    end 

    def show 
        correct_answer = CorrectAnswer.find(params[:id])
        render json: correct_answer, include: [:question => {only: [:id, :message]}]
    end 

    def create 
        correct_answer = CorrectAnswer.create(
            message: params[:message],
            question_id: params[:question_id]
        )
        render json: correct_answer, include: [:question => {only: [:id, :message]}]
    end 

    def update 
        correct_answer = CorrectAnswer.find(params[:id])
        correct_answer.update(
            message: params[:message],
            question_id: params[:question_id]
        )
        render json: correct_answer, include: [:question => {only: [:id, :message]}]
    end 

    def destroy
        correct_answer = CorrectAnswer.find(params[:id])
        correct_answer.destroy
        render json: {message: "This answer has been destroyed.", status: 204}
    end 
end
