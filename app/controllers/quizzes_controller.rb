class QuizzesController < ApplicationController
    def index 
        quizzes = Quiz.all 
        render json: quizzes, 
            include: [:questions => {
                include: [
                    :correct_answer => {only: [:id, :message]}, 
                    :incorrect_answers => {only: [:id, :message]}, 
                    :category => {only: [:id, :name]}
                ], 
                except: [:category_id, :created_at, :updated_at]
            }]
    end 

    def show 
        quiz = Quiz.find(params[:id])
        render jsson: quiz, 
            include: [:questions => {
                include: [
                    :correct_answer => {only: [:id, :message]}, 
                    :incorrect_answers => {only: [:id, :message]}, 
                    :category => {only: [:id, :name]}
                ], 
                except: [:category_id, :created_at, :updated_at]
            }]
    end 
end
