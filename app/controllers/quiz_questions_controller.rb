class QuizQuestionsController < ApplicationController
    def index 
        quiz_questions = QuizQuestion.all
        render json: quiz_questions, 
            include: [
                :quiz => {only: [:id, :name]}, 
                :question => {
                    include: [
                        :category => {except: [:created_at, :updated_at]}], 
                    except: [:category_id, :created_at, :updated_at]
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
                        :category => {except: [:created_at, :updated_at]}], 
                    except: [:category_id, :created_at, :updated_at]
                }], 
            except: [:quiz_id, :question_id, :created_at, :updated_at]
    end 
end
