class QuizzesController < ApplicationController
    def index 
        quizzes = Quiz.all 
        render_quiz(quizzes)
    end 

    def show 
        quiz = Quiz.find(params[:id])
        render_quiz(quiz)
    end 

    def update
        quiz = Quiz.find(params[:id])
        quiz.update(name: quiz_params[:name])
        render_quiz(quiz)
    end 

    private 
    
    def quiz_params 
        params.require(:quiz).permit(:name)
    end 

    def render_quiz (quiz)
        render json: quiz, 
            include: [:questions => {
                include: [
                    :correct_answer => {only: [:id, :message]}, 
                    :incorrect_answers => {only: [:id, :message]}
                ], 
                except: [:category_id, :created_at, :updated_at, :study_card]
            }], 
            except: [:created_at, :updated_at]
    end 
end
