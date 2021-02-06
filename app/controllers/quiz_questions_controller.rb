class QuizQuestionsController < ApplicationController
    def index 
        quiz_questions = QuizQuestion.all
        render json: quiz_questions, 
            include: [
                :quiz => {only: [:id, :name]}, 
                :question => {
                    include: [
                        :correct_answer => {only: [:id, :message]}, 
                        :incorrect_answers => {only: [:id, :message]}
                    ], 
                    except: [:category_id, :created_at, :updated_at, :study_card]
                }], 
            except: [:quiz_id, :question_id, :created_at, :updated_at]
    end 

    def show 
        quiz_question = QuizQuestion.find(params[:id])
        render json: quiz_question, 
            include: [
                :quiz => {only: [:id, :name]}, 
                :question => {
                    include: [
                        :correct_answer => {only: [:id, :message]}, 
                        :incorrect_answers => {only: [:id, :message]}
                    ], 
                    except: [:category_id, :created_at, :updated_at, :study_card]
                }], 
            except: [:quiz_id, :question_id, :created_at, :updated_at]
    end 
end
