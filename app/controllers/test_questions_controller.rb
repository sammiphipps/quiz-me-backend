class TestQuestionsController < ApplicationController
    def index 
        test_questions = TestQuestion.all
        render json: test_questions, 
            include: [
                :test => {only: [:id, :name]}, 
                :question => {
                    include: [
                        :correct_answer => {only: [:id, :message]}, 
                        :incorrect_answers => {only: [:id, :message]}
                    ], 
                    except: [:category_id, :created_at, :updated_at, :study_card]
                }], 
            except: [:test_id, :question_id, :created_at, :updated_at]
    end 

    def show 
        test_question = TestQuestion.find(params[:id])
        render json: test_question, 
            include: [
                :test => {only: [:id, :name]}, 
                :question => {
                    include: [
                        :correct_answer => {only: [:id, :message]}, 
                        :incorrect_answers => {only: [:id, :message]}
                    ], 
                    except: [:category_id, :created_at, :updated_at, :study_card]
                }], 
            except: [:test_id, :question_id, :created_at, :updated_at]
    end 
end
