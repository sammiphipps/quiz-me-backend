class QuizzesController < ApplicationController
    def index 
        quizzes = Quiz.all 
        render json: quizzes
    end 

    def show 
        quiz = Quiz.find(params[:id])
        render jsson: quiz
    end 
end
