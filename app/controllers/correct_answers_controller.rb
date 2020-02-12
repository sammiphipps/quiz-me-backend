class CorrectAnswersController < ApplicationController
    def index 
        correct_answers = CorrectAnswer.all
        render json: correct_answers, include: [:question => {only: [:id, :message]}], except: [:created_at, :updated_at]
    end 

    def show 
        correct_answer = CorrectAnswer.find(params[:id])
        render json: correct_answer, include: [:question => {only: [:id, :message]}], except: [:created_at, :updated_at]
    end 

    def create 
        correct_answer = CorrectAnswer.create(correct_answer_params)
        render json: correct_answer, include: [:question => {only: [:id, :message]}], except: [:created_at, :updated_at]
    end 

    def update 
        correct_answer = CorrectAnswer.find(params[:id])
        correct_answer.update(correct_answer_params)
        render json: correct_answer, include: [:question => {only: [:id, :message]}], except: [:created_at, :updated_at]
    end 

    def destroy
        correct_answer = CorrectAnswer.find(params[:id])
        correct_answer.destroy
        render json: {message: "This answer has been destroyed.", status: 204}
    end 

    private

    def correct_answer_params
        params.require(:correct_answer).permit(:message, :question_id)
    end 
end
