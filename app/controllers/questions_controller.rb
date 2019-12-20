class QuestionsController < ApplicationController
    def index 
        questions = Question.all
        render json: questions, include: [:category => {only: [:id, :name]}, :correct_answer => {only: [:id, :message]}, :incorrect_answers => {only: [:id, :message]}]
    end 

    def show 
        question = Question.find(params[:id])
        render json: question, include: [:category => {only: [:id, :name]}, :correct_answer => {only: [:id, :message]}, :incorrect_answers => {only: [:id, :message]}]
    end 
end
