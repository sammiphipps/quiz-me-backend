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
            connection_info = create_multiple_connections(question_ids, quiz_id)
            byebug

        else
            question_id = quiz_question_params[:question_id]
            created = create_single_connection(question_id, quiz_id)
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
                create << id 

                # QuizQuestion.create(
                #     quiz_id: quiz_id,
                #     question_id: id
                # )
            else 
                unable_create << id
            end 
        end 

        return {
            created: create, 
            not_created: unable_create
        }


        #     if created.empty? === false & unable_create.empty? === true 
        #         # everything created
        #         quiz_questions = QuizQuestion.find(created)
        #         byebug
        #         render json: quiz_questions, 
        #         include: [
        #             :quiz => {only: [:id, :name]}, 
        #             :question => {
        #                 include: [
        #                     :correct_answer => {only: [:id, :message]}, 
        #                     :incorrect_answers => {only: [:id, :message]}
        #                 ], 
        #                 except: [:category_id, :created_at, :updated_at, :study_card]
        #             }], 
        #         except: [:quiz_id, :question_id, :created_at, :updated_at]
        #     elsif created.empty? === true && unable_create.empty? === false 
        #         # unable to create anything 
        #         render json: {message: "Unable to create a connections for questions that have the following ids #{unable_create} to quiz #{quiz_id}"}
                #     else 
        #         # mix of created and unable to create 
        #         quiz_questions = QuizQuestion.find(created)
        #         byebug
        #         render :message => "Unable to create a connection for questions that have the following ids #{unable_create} to quiz #{quiz_id}",  :created => quiz_questions, 
        #         include: [
        #             :quiz => {only: [:id, :name]}, 
        #             :question => {
        #                 include: [
        #                     :correct_answer => {only: [:id, :message]}, 
        #                     :incorrect_answers => {only: [:id, :message]}
        #                 ], 
        #                 except: [:category_id, :created_at, :updated_at, :study_card]
        #             }], 
        #         except: [:quiz_id, :question_id, :created_at, :updated_at]
        #     end 
    end 

    def create_single_connection(question_id, quiz_id)
        exists = already_exist?(question_id, quiz_id)

        if !exists
            p "Quiz Question #{question_id} does not exist; need to create"

            # QuizQuestion.create(
            #     quiz_id: quiz_id, 
            #     question_id: question_id
            # )
            return true
        else 
            p "Quiz Question #{question_id} already exists, do not need to create"
            return false
        end 
    end 
end
