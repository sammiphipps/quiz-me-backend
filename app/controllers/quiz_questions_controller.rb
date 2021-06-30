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

    def create 
        if quiz_question_params.has_key?(:question_ids) === true && quiz_question_params.has_key?(:question_id) === false
            created = []
            unable_create = []
            quiz_id = quiz_question_params[:quiz_id]
            question_ids = JSON.parse(quiz_question_params[:question_ids])
            
            question_ids.each do |id|
                exists = already_exists(quiz_id, id)
                
                if exists === false 
                    created << id
                    p "Quiz Question #{id} does not exist; need to create"

                    # QuizQuestion.create(
                    #     quiz_id: quiz_question_params[:quiz_id]
                    #     question_id: quiz_question_params[:question_id]
                    # )
                else 
                    unable_create << id
                    p "Quiz Question #{id} already exists; do not need to create"
                end 
            end 

            if created.empty? === false & unable_create.empty? === true 
                # everything created
                quiz_questions = QuizQuestion.find(created)
                byebug
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
            elsif created.empty? === true && unable_create.empty? === false 
                # unable to create anything 
                render json: {message: "Unable to create a connections for questions that have the following ids #{unable_create} to quiz #{quiz_id}"}
            else 
                # mix of created and unable to create 
                quiz_questions = QuizQuestion.find(created)
                byebug
                render :message => "Unable to create a connection for questions that have the following ids #{unable_create} to quiz #{quiz_id}",  :created => quiz_questions, 
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
        elsif quiz_question_params.has_key?(:question_ids) === false && quiz_question_params.has_key?(:question_id) === true
            exists = already_exists(quiz_question_params[:quiz_id], quiz_question_params[:question_id])
            if  exists === false
                p "Quiz Question #{quiz_question_params[:question_id]} does not exist; need to create"

                # QuizQuestion.create(
                #     quiz_id: quiz_question_params[:quiz_id]
                #     question_id: quiz_question_params[:question_id]
                # )
            else 
                p "Quiz Question #{quiz_question_params[:question_id]} already exists; do not need to create"
            end 
        end 
    end 

    private 

    def quiz_question_params
        params.require(:quiz_question).permit(:quiz_id, :question_ids, :question_id)
    end 

    def already_exists( quiz_id, question_id)
        quiz = Quiz.find(quiz_id)
        if quiz.is_a?(Quiz) === true 
            questions = quiz.questions 
            if questions.exists?(question_id)
                return true
            else
                return false  
            end 
        else
            return false 
        end 
    end 
end
