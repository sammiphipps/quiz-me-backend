class TestsController < ApplicationController
    def index 
        tests = Test.all
        render json: tests, 
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
        test = Test.find(params[:id])
        render json: test, 
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
