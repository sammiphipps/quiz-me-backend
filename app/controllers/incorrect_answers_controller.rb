class IncorrectAnswersController < ApplicationController
    def index 
        incorrect_answers = IncorrectAnswer.all
        render json: incorrect_answers, include: [:question => {only: [:id, :message]}]
    end 

    def show 
        incorrect_answer = IncorrectAnswer.find(params[:id])
        render json: incorrect_answer, include: [:question => {only: [:id, :message]}]
    end 
end
