class CorrectAnswersController < ApplicationController
    def index 
        correct_answers = CorrectAnswer.all
        render json: correct_answers, include: [:question => {only: [:id, :message]}]
    end 

    def show 
        correct_answer = CorrectAnswer.find(params[:id])
        render json: correct_answer, include: [:question => {only: [:id, :message]}]
    end 
end
