class TestQuestionsController < ApplicationController
    def index 
        test_questions = TestQuestion.all
        render json: test_questions, 
            include: [
                :test => {only: [:id, :name]}, 
                :question => {
                    include: [
                        :category => {except: [:created_at, :updated_at]}], 
                    except: [:category_id, :created_at, :updated_at]
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
                        :category => {except: [:created_at, :updated_at]}], 
                    except: [:category_id, :created_at, :updated_at]
                }], 
            except: [:test_id, :question_id, :created_at, :updated_at]
    end 
end
