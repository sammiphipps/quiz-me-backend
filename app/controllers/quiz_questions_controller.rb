class QuizQuestionsController < ApplicationController
    def index 
        quiz_questions = QuizQuestion.all
        quiz_question_render(quiz_questions)
    end 

    def show 
        quiz_question = QuizQuestion.find(params[:id])
        quiz_question_render(quiz_question)
    end 

    def create 

        quiz_id = quiz_question_params[:quiz_id]

        if quiz_question_params.has_key?(:question_ids)
            #if params contains multiple question ids 
            question_ids = JSON.parse(quiz_question_params[:question_ids])
            quiz_questions = create_multiple_connections(question_ids, quiz_id)
            
            if quiz_questions[:not_created].length === question_ids.length
                already_connected_render(true)
            else 
                quiz_question_render(quiz_questions[:created])
            end 
            
        else
            question_id = quiz_question_params[:question_id]
            quiz_question = create_single_connection(question_id, quiz_id)
            
            if quiz_question.nil? 
                already_connected_render
            else
                quiz_question_render(quiz_question) 
            end 
        end 
    end 

    

    private 

    def quiz_question_params
        params.require(:quiz_question).permit(:quiz_id, :question_ids, :question_id)
    end 

    def quiz_question_render (quiz_question)
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

    def already_connected_render(multiple = false)
        render json: { message: "#{ multiple ? 'Questions' : 'Question' } provided are already connected to quiz" }
    end 

    def already_exist?(question_id, quiz_id)
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

    def create_multiple_connections(question_ids, quiz_id)
        create = []
        unable_create = []

        question_ids.each do |id|
            exists = already_exist?(id, quiz_id)
            if !exists 
                quiz_question = QuizQuestion.create(
                    quiz_id: quiz_id, 
                    question_id: id
                )

                create << quiz_question
            else 
                unable_create << id
            end 
        end 

        return {
            created: create, 
            not_created: unable_create
        }
    end 

    def create_single_connection(question_id, quiz_id)
        exists = already_exist?(question_id, quiz_id)

        if !exists
             quiz_question = QuizQuestion.create(
                 quiz_id: quiz_id, 
                 question_id: question_id
             )

             return quiz_question
        end 
    end 
end
